//
//  RecoverPasswordViewController.swift
//  SwitcHome
//
//  Created by José Manuel Rivera García on 24/1/18.
//  Copyright © 2018 DomoticSolutions. All rights reserved.
//

import UIKit
import TextFieldEffects
import ZAlertView
import Toast_Swift

class RecoverPasswordViewController: UIViewController {
    
    
    @IBOutlet weak var userName: AkiraTextField!
    @IBOutlet weak var emailTextField: AkiraTextField!
    @IBOutlet weak var recoverPassBTN: UIButton!
    var dataManager = DataManager()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recoverPassBTN.layer.cornerRadius = 20
        userName.backgroundColor = UIColor.clear
        emailTextField.backgroundColor = UIColor.clear
    }

    @IBAction func recoverPass(_ sender: UIButton) {
        
        if (userName.text?.isEmpty)! || (emailTextField.text?.isEmpty)!{
            self.view.makeToast("Es necesario que todos los parametros esten rellenos", duration: 3.0, position: .top)
            
        }else if !(emailTextField.text?.isValidEmail())! {
            self.view.makeToast("La contraseña debe tener al menos 6 caracteres", duration: 3.0, position: .top)
        }else{
            recoverPass(params: ["name": userName.text!, "email": emailTextField.text!])
        }
    }
    
    func recoverPass(params: [String: Any]) {
        dataManager.getRecoverPass(params: params) { (json) in
            if json.code == 200 {
                UserDefaults.standard.set(json.data["token"] , forKey: "token")
                self.buildAndShowPopUp()
            } else if json.code == 401 || json.code == 419{
                self.view.makeToast(json.message , duration: 3.0, position: .top)
            } else if json.code == 400 || json.code == 500 {
                print(String(describing:json))
            }
        }
    }
    
    func buildAndShowPopUp() {
        
        ZAlertView.textFieldBorderColor = #colorLiteral(red: 0.1058823529, green: 0.6039215686, blue: 0.968627451, alpha: 1)
        ZAlertView.positiveColor = #colorLiteral(red: 0.1058823529, green: 0.6039215686, blue: 0.968627451, alpha: 1)
        ZAlertView.messageColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        ZAlertView.titleColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        
        
        let dialog = ZAlertView(title: "Cambiar contraseña", message: "Introduce tu nueva contraseña", isOkButtonLeft: false, okButtonText: "CAMBIAR", cancelButtonText: "CANCELAR", okButtonHandler: { (alert) in
            let pass = alert.getTextFieldWithIdentifier("pass")?.text
            let repeatPass = alert.getTextFieldWithIdentifier("repeatPass")?.text
            
            self.checkPass(pass: pass!, repeatPass: repeatPass!, alert: alert)
            
            UserDefaults.standard.set("" , forKey: "token")
            
        }) { (alert) in
            UserDefaults.standard.set("" , forKey: "token")
            alert.dismissAlertView()
            
        }
        
        dialog.addTextField("pass", placeHolder: "Contraseña", isSecured: true)
        let passTF = dialog.getTextFieldWithIdentifier("pass")
        passTF?.backgroundColor = UIColor.clear
        
        dialog.addTextField("repeatPass", placeHolder: "Repetir ontraseña", isSecured: true)
        let passRepeatTF = dialog.getTextFieldWithIdentifier("repeatPass")
        passRepeatTF?.backgroundColor = UIColor.clear
        
        dialog.show()
    }
    
    func checkPass(pass: String, repeatPass: String, alert: ZAlertView) {
        if (pass.count) < 6 {
            self.view.makeToast("La contraseña debe de tener como mínimo 6 carácteres" , duration: 3.0, position: .top)
        }else if pass != repeatPass {
            self.view.makeToast("Las contraseñas deben de coincidir" , duration: 3.0, position: .top)
        }else{
            self.updatePass(pass: pass)
            alert.dismissAlertView()
        }
    }
    
    func updatePass(pass: String) {
        self.dataManager.postUpdatePass(params: ["pass": pass as Any], completionHandler: { (json) in
            if json.code == 201 {
                self.performSegue(withIdentifier: "goToLogin", sender: nil)
            } else if json.code == 401 || json.code == 419{
                self.view.makeToast(json.message , duration: 3.0, position: .top)
            } else if json.code == 400 || json.code == 500 {
                print(String(describing:json))
            }
            
        })
    }
    

}
