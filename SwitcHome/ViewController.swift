//
//  ViewController.swift
//  SwitcHome
//
//  Created by alumnos on 12/1/18.
//  Copyright © 2018 DomoticSolutions. All rights reserved.
//

import UIKit
import KohanaTextField
import Toast_Swift

class ViewController: UIViewController {
    var Login = false
    
    @IBOutlet weak var UsernameField: KohanaTextField!
    
    @IBOutlet weak var PasswordField: KohanaTextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginButton.layer.cornerRadius = 15
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func LoginButtonAction(_ sender: Any) {
        
        if (UsernameField.text?.isEmpty)! || (PasswordField.text?.isEmpty)!{
            self.view.makeToast("Rellena los campos requeridos", duration: 3.0, position: .top)
            Login = false
        }else{
            Login = true
            
        }
        if(PasswordField.text?.count)! < 6{
            
            self.view.makeToast("La contraseña debe tener al menos 6 caracteres", duration: 3.0, position: .top)
            Login = false
            
        }
    }
    
    
    
    
    
    
}

