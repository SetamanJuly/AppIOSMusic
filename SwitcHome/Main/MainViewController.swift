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
    
    @IBOutlet weak var userNameTF: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainNavigationController = navigationController!
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftNavigationMenu") as! UISideMenuNavigationController
        
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuFadeStatusBar = false
        
        initializeUsername()
    }
    @IBAction func showMenu(_ sender: UIButton) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }

    
    func initializeUsername() {
        if let username = UserDefaults.standard.value(forKey: "username")
        {
            userNameTF.text = username as? String
        } else {
            userNameTF.text = "Usuario"
        }
    }


}
