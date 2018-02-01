//
//  ProfileViewController.swift
//  SwitcHome
//
//  Created by José Manuel Rivera García on 29/1/18.
//  Copyright © 2018 DomoticSolutions. All rights reserved.
//

import UIKit
import SideMenu
import ZAlertView
import Toast_Swift

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var changeProfileBTN: UIButton!
    @IBOutlet weak var changePassBTN: UIButton!
    @IBOutlet weak var changeEmailBTN: UIButton!
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftNavigationMenu") as! UISideMenuNavigationController
        
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        changeProfileBTN.layer.cornerRadius = 15
        changePassBTN.layer.cornerRadius = 15
        changeEmailBTN.layer.cornerRadius = 15
        
        loadPhoto()
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func changePass(_ sender: UIButton) {
        buildAndShowPopUpChangePass()
    }
    
    @IBAction func changeEmail(_ sender: UIButton) {
        buildAndShowPopUpChangeEmail()
    }
    
    @IBAction func changePhoto(_ sender: UIButton) {
        buildAndShowPopUpChangePhoto()
    }
    
    
    func buildAndShowPopUpChangePass() {
        //Se crea el alert con un estilo y se muestra
        ZAlertView.textFieldBorderColor = #colorLiteral(red: 0.1058823529, green: 0.6039215686, blue: 0.968627451, alpha: 1)
        ZAlertView.positiveColor = #colorLiteral(red: 0.1058823529, green: 0.6039215686, blue: 0.968627451, alpha: 1)
        ZAlertView.negativeColor = #colorLiteral(red: 0.8538075089, green: 0.01684000529, blue: 0.1194023266, alpha: 1)
        ZAlertView.messageColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        ZAlertView.titleColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        
        let dialog = ZAlertView(title: "Cambiar contraseña", message: "Introduce tu nueva contraseña", isOkButtonLeft: false, okButtonText: "CAMBIAR", cancelButtonText: "CANCELAR", okButtonHandler: { (alert) in
            let pass = alert.getTextFieldWithIdentifier("pass")?.text
            let repeatPass = alert.getTextFieldWithIdentifier("repeatPass")?.text
            
            self.checkPass(pass: pass!, repeatPass: repeatPass!, alert: alert)

        }) { (alert) in

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
        //Se comprueban los campos en el alert
        if (pass.count) < 6 {
            alert.view.makeToast("La contraseña debe de tener como mínimo 6 carácteres" , duration: 3.0, position: .top)
        }else if pass != repeatPass {
            alert.view.makeToast("Las contraseñas deben de coincidir" , duration: 3.0, position: .top)
        }else{
            postUpdateUser(params: ["pass": pass])
            alert.dismissAlertView()
        }
    }
    
    func buildAndShowPopUpChangeEmail() {
        //Se crea el alert con un estilo y se muestra
        ZAlertView.textFieldBorderColor = #colorLiteral(red: 0.1058823529, green: 0.6039215686, blue: 0.968627451, alpha: 1)
        ZAlertView.positiveColor = #colorLiteral(red: 0.1058823529, green: 0.6039215686, blue: 0.968627451, alpha: 1)
        ZAlertView.negativeColor = #colorLiteral(red: 0.8538075089, green: 0.01684000529, blue: 0.1194023266, alpha: 1)
        ZAlertView.messageColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        ZAlertView.titleColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        
        let dialog = ZAlertView(title: "Cambiar email", message: "Introduce tu nuevo email", isOkButtonLeft: false, okButtonText: "CAMBIAR", cancelButtonText: "CANCELAR", okButtonHandler: { (alert) in
            let email = alert.getTextFieldWithIdentifier("email")?.text
            
            self.checkEmail(email: email!, alert: alert)
            
        }) { (alert) in
            
            alert.dismissAlertView()
        }
        
        dialog.addTextField("email", placeHolder: "Email")

        let passTF = dialog.getTextFieldWithIdentifier("pass")
        passTF?.backgroundColor = UIColor.clear
        
        
        dialog.show()
    }
    
    func checkEmail(email: String, alert: ZAlertView) {
        if email.isValidEmail() {
            postUpdateUser(params: ["email": email])
            alert.dismissAlertView()
        }else{
            alert.view.makeToast("El email debe de tener un formato válido" , duration: 3.0, position: .top)
        }
    }
    
    func postUpdateUser(params: [String: Any]) {
        dataManager.postUpdateUser(params: params, image: nil) { (json) in
            if json.code == 201 {
                UserDefaults.standard.set(json.data["token"], forKey: "token")
                self.view.makeToast(json.message, duration: 3.0, position: .top)
            } else if json.code == 401 || json.code == 419{
                self.view.makeToast(json.message, duration: 3.0, position: .top)
            } else if json.code == 400 || json.code == 500 {
                print(String(describing:json.message))
            }
        }
    }
    
    func buildAndShowPopUpChangePhoto() {
        //Se crea el alert con un estilo y se muestra
        ZAlertView.positiveColor = #colorLiteral(red: 0.1058823529, green: 0.6039215686, blue: 0.968627451, alpha: 1)
        ZAlertView.negativeColor = #colorLiteral(red: 0.9960784314, green: 0.768627451, blue: 0.09411764706, alpha: 1)
        ZAlertView.messageColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        ZAlertView.titleColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        
        let dialog = ZAlertView(title: "Cambiar foto", message: "¿Quieres hacer una nueva foto o usar tu galería?", isOkButtonLeft: false, okButtonText: "GALERÍA", cancelButtonText: "CAMARA", okButtonHandler: { (alert) in
            self.pickImageFromGalery()
            alert.dismissAlertView()
        }) { (alert) in
            self.pickImageFromCamera()
            alert.dismissAlertView()
        }
        dialog.show()
    }
    
    func pickImageFromGalery() {
        let imageSelector = UIImagePickerController()
        imageSelector.delegate = self
        imageSelector.sourceType = .photoLibrary
        self.present(imageSelector, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage]
            as! UIImage
        
        profileImage.image = image
        savePhoto()
        postChangeImage(image: image)
        
        dismiss(animated: true, completion: nil)
    }
    
    func postChangeImage(image: UIImage) {
        
        dataManager.postUpdateUser(params: [:], image: image) { (json) in
            
            if json.code == 201 {
                let user: [String: Any] = json.data["user"] as! [String: Any]

                UserDefaults.standard.set(user["url_photo"], forKey: "profileImage")
                
                print(UserDefaults.standard.value(forKey: "profileImage") as Any)
                self.view.makeToast(json.message, duration: 3.0, position: .top)
            } else if json.code == 401 || json.code == 419{
                self.view.makeToast(json.message, duration: 3.0, position: .top)
            } else if json.code == 400 || json.code == 500 {
                print(String(describing:json.message))
            }
        }
    }
    func pickImageFromCamera() {
        if
            UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imageSelector = UIImagePickerController()
            imageSelector.delegate = self
            imageSelector.sourceType = .camera
            self.present(imageSelector, animated: true, completion: nil)
        } else {
            pickImageFromGalery()
        }
    }
    
    func savePhoto() {
        let fileManager = FileManager.default
        
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("foto.jpg")
        
        fileManager.createFile(atPath: imagePath as String, contents: UIImageJPEGRepresentation( profileImage.image!, 1.0))
    }
    
    func loadPhoto() {
        let fileManager = FileManager.default
        
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("foto.jpg")
        
        if fileManager.fileExists(atPath: imagePath) {
            profileImage.image = UIImage(contentsOfFile: imagePath)
        } else {
            print("La imagen no existe")
        }
    }
}
