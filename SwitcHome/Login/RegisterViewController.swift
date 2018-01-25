//
//  RegisterViewController.swift
//  SwitcHome
//
//  Created by alumnos on 17/1/18.
//  Copyright © 2018 DomoticSolutions. All rights reserved.
//

import UIKit
import TextFieldEffects

class RegisterViewController: UIViewController {

    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var nameTextField: AkiraTextField!
    @IBOutlet weak var emailTextField: AkiraTextField!
    @IBOutlet weak var passwordTextField: AkiraTextField!
    @IBOutlet weak var repeatPasswordTextField: AkiraTextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //Declaración de un data manager para usar servicios
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.backgroundColor = UIColor.clear
        emailTextField.backgroundColor = UIColor.clear
        passwordTextField.backgroundColor = UIColor.clear
        repeatPasswordTextField.backgroundColor = UIColor.clear
        RegisterButton.layer.cornerRadius = 20
        hideActivityIndicator()
    }
    
    @IBAction func userRegister(_ sender: UIButton) {
        //Se comprueban que todos los campos sean válidos y se hace la llamada a la API
        if (nameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! {
            self.view.makeToast("Es necesario que todos los parametros esten rellenos", duration: 3.0, position: .top)
        }else if (passwordTextField.text?.count)! < 6{
            self.view.makeToast("La contraseña debe tener al menos 6 caracteres", duration: 3.0, position: .top)
        }else if passwordTextField.text != repeatPasswordTextField.text{
            self.view.makeToast("Las contraseñas deben de coincidir", duration: 3.0, position: .top)
        }else if !(emailTextField.text?.isValidEmail())!{
            self.view.makeToast("El email debe de tener un formato adecuado", duration: 3.0, position: .top)
        }else{
            showActivityIndicator()
            register(parameters: ["name": nameTextField.text!, "pass": passwordTextField.text!, "email": emailTextField.text!])
        }
    }
    
    func register(parameters: [String: Any]) {
        //Se hace la llamada a la API y se filtran los códigos de respuesta
        dataManager.postCreateUser(params: parameters) { (json) in
            if json.code == 201 {
                self.performSegue(withIdentifier: "goToLogin", sender: nil)
            } else if json.code == 401 || json.code == 419{
                self.view.makeToast(json.message , duration: 3.0, position: .top)
            } else if json.code == 400 || json.code == 500 {
                print(String(describing:json))
            }
            self.hideActivityIndicator()
        }
        
    }
    
    //Funciones para mostrar y quitar el activity indicator
    func showActivityIndicator() {
        RegisterButton.isHidden = true
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.RegisterButton.isHidden = false
    }

}
