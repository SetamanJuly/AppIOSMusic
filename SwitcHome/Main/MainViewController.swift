//
//  MainViewController.swift
//  SwitcHome
//
//  Created by José Manuel Rivera García on 23/1/18.
//  Copyright © 2018 DomoticSolutions. All rights reserved.
//

import UIKit
import SideMenu
class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftNavigationMenu") as! UISideMenuNavigationController
        
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController

//        userImage.layer.cornerRadius = userImage.frame.size.width / 2
//        userImage.layer.masksToBounds = true
//        userImage.layer.borderColor = #colorLiteral(red: 0.01176470588, green: 0.662745098, blue: 0.9568627451, alpha: 1)
//        userImage.layer.borderWidth = 5
    }
    @IBAction func showMenu(_ sender: UIButton) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }

    
//    func initializeUsername() {
//        if let username = UserDefaults.standard.value(forKey: "username")
//        {
//            userName.text = username as? String
//        } else {
//            userName.text = "Usuario"
//        }
//    }


}
