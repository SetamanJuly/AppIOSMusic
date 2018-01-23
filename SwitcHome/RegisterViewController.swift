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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.backgroundColor = UIColor.clear
        emailTextField.backgroundColor = UIColor.clear
        passwordTextField.backgroundColor = UIColor.clear
        repeatPasswordTextField.backgroundColor = UIColor.clear
        RegisterButton.layer.cornerRadius = 20
        
        // Do any additional setup after loading the view.
    }

    


}
