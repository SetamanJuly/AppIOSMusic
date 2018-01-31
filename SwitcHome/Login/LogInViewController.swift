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
    
    //Declaración de un data manager para usar servicios
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkTheme()
        checkFollow()
        
        nameTextField.backgroundColor = UIColor.clear
        passwordTextField.backgroundColor = UIColor.clear
        loginBTNOulet.layer.cornerRadius = 20
        hideActivityIndicator()
        //Se define el estilo de los toast
        toastStyle.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.8235294118, blue: 0.981543839, alpha: 1)
        toastStyle.messageColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        toastStyle.messageFont = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        ToastManager.shared.style = toastStyle
        
        checkLog()
    }
    @IBAction func loginBTN(_ sender: UIButton) {
        //Se coimprueban que los campos sean válidos y se hace una llamada a la API
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
        //Se hace la llamada a la API y se filtran los códigos de respuesta
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
    
    func checkLog() {
        if UserDefaults.standard.value(forKey: "token") as? String != nil {
            dataManager.getAuth { (json) in
                if json.code == 200 {
                    self.performSegue(withIdentifier: "goToMain", sender: nil)
                } else if json.code == 401 || json.code == 419{
                    
                } else if json.code == 400 || json.code == 500 {
                    print(String(describing:json.message))
                }
            }
        }
    }
    
    //Funciones para mostrar y quitar el activity indicator
    func showActivityIndicator() {
        loginBTNOulet.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        loginBTNOulet.isHidden = false
    }
    
    func checkTheme() {
        let appStyle = UserDefaults.standard.value(forKey: "appStyle")
        if appStyle == nil {
            UserDefaults.standard.set("night", forKey: "appStyle")
        }else{
            //cambiar colores en función del estilo de la app
        }
    }
    
    func checkFollow() {
        let follow = UserDefaults.standard.value(forKey: "follow")
        if follow == nil {
            UserDefaults.standard.set(false, forKey: "follow")
        }else{
            //Configurar posición
        }
    }

}
