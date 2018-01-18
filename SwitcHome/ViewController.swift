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
import Alamofire

class ViewController: UIViewController {
    var Login = false
    
    
    @IBOutlet weak var UsernameField: KohanaTextField!
    
    @IBOutlet weak var PasswordField: KohanaTextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginButton.layer.cornerRadius = 15
        PasswordField.layer.cornerRadius = 10
        UsernameField.layer.cornerRadius = 10
        
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func LoginButtonAction(_ sender: Any) {
        
        if (UsernameField.text?.isEmpty)! || (PasswordField.text?.isEmpty)!{
            self.view.makeToast("Rellena los campos requeridos", duration: 3.0, position: .top)
           
        }else{
            
            
        }
        if(PasswordField.text?.count)! < 6{
            
            self.view.makeToast("La contraseña debe tener al menos 6 caracteres", duration: 3.0, position: .top)
            
            
        }
        if (UsernameField.text != nil) && (PasswordField.text != nil){
            LoginTrue()
          
            
        }
       
}
    func LoginTrue() {
        
        let urlHardcoded = URL(string:"h2744356.stratoserver.net/domotics/serverIoTApi/public/index.php/users/login.json")
        let parameters: Parameters = [
            "user":"",
            "password":""
        ]
        
        Alamofire.request(urlHardcoded!, method: .get, parameters: parameters).responseJSON(completionHandler: {response in
            print("Request :: \(String(describing:response.request))")
            print("Response :: \(String(describing:response.response))")
            print("Result :: \(String(describing:response.result))")
            
            switch response.result {
            case .success:
                if let json = response.result.value {
                    print("JSON :: \(json)")
                }
            case .failure:
                print("Error :: \(String(describing: response.error))")
            }
        })    }
    
    

}
