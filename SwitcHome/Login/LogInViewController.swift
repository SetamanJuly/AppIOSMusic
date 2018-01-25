//
//  LogInViewController.swift
//  SwitcHome
//
//  Created by José Manuel Rivera García on 22/1/18.
//  Copyright © 2018 DomoticSolutions. All rights reserved.
//

import UIKit
import Toast_Swift
import TextFieldEffects

class LogInViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: AkiraTextField!
    @IBOutlet weak var passwordTextField: AkiraTextField!
    @IBOutlet weak var loginBTNOulet: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var toastStyle = ToastStyle() //Estilo del toast
    

    
    let parameters: [String: Any] = ["name": "test1", "pass": "test12", "email": "test1@test.com"]
    let headers: [String: String] = ["Content-Type": "application/x-www-form-urlencoded"]
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.backgroundColor = UIColor.clear
        passwordTextField.backgroundColor = UIColor.clear
        loginBTNOulet.layer.cornerRadius = 20
        hideActivityIndicator()
        
        toastStyle.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        toastStyle.messageColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        ToastManager.shared.style = toastStyle

       
    }
    @IBAction func loginBTN(_ sender: UIButton) {
        
        if (nameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!{
            self.view.makeToast("Es necesario que todos los parametros esten rellenos", duration: 3.0, position: .top)
            
        }else if(passwordTextField.text?.count)! < 6{
            self.view.makeToast("La contraseña debe tener al menos 6 caracteres", duration: 3.0, position: .top)
        }else{
            showActivityIndicator()
            login(parameters: ["name": nameTextField.text!, "pass": passwordTextField.text!])
        }

        
    }
    func login(parameters: [String: Any]){
        dataManager.getLogin(params: parameters) { (json) in
            if json.code == 200 {
                UserDefaults.standard.set(json.data["token"] , forKey: "token")
                UserDefaults.standard.set(json.data["name"], forKey: "username")
                self.performSegue(withIdentifier: "goToMain", sender: nil)
            } else if json.code == 401 || json.code == 419{
                self.view.makeToast(json.message , duration: 3.0, position: .top)
                
            } else if json.code == 400 || json.code == 500 {
                print(String(describing:json))
            }
            self.hideActivityIndicator()
        }
    }
    
    func showActivityIndicator() {
        loginBTNOulet.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        loginBTNOulet.isHidden = false
    }

}
