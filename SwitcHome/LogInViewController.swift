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
    
    let parameters: [String: Any] = ["name": "test1", "pass": "test12", "email": "test1@test.com"]
    let headers: [String: String] = ["Content-Type": "application/x-www-form-urlencoded"]
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.backgroundColor = UIColor.clear
        passwordTextField.backgroundColor = UIColor.clear
        loginBTNOulet.layer.cornerRadius = 20
//        dataManager.getLogin(params: parameters, headers: headers, completionHandler: {(json) in
//            print("ME CAGO EN DIOS: \(json)")
//        })
//        requestController.makePostRequest(url: url, params: parameters, headers: headers, completionHandler: {(json) in
//                print(json.data)
//        })
//        dataManager.postCreateUser(params: parameters, headers: headers, completionHandler: {(json) in
//            print("ME CAGO EN DIOS: \(json.message)")
//        })
       
    }
    @IBAction func loginBTN(_ sender: UIButton) {
        
        if (nameTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!{
            self.view.makeToast("Es necesario que todos los parametros esten rellenos", duration: 3.0, position: .top)
            
        }else if(passwordTextField.text?.count)! < 6{
            self.view.makeToast("La contraseña debe tener al menos 6 caracteres", duration: 3.0, position: .top)
        }else{
            login(parameters: ["name": nameTextField.text!, "pass": passwordTextField.text!], headers: [:])
        }

        
    }
    func login(parameters: [String: Any], headers: [String: String]){

        dataManager.getLogin(params: parameters, headers: headers) { (json) in
            if json.code == 200 {
                print("todo ha salido bien")
                //ir al main
            } else if json.code == 401 || json.code == 419{
                self.view.makeToast(json.message , duration: 3.0, position: .top)
            } else if json.code == 400 || json.code == 500 {
                print(String(describing:json))
            }
            
            
        }
    }
    

    
    

}
