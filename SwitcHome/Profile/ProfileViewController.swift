//
//  ProfileViewController.swift
//  SwitcHome
//
//  Created by José Manuel Rivera García on 29/1/18.
//  Copyright © 2018 DomoticSolutions. All rights reserved.
//

import UIKit
import SideMenu

class ProfileViewController: UIViewController {

    @IBOutlet weak var changeProfileBTN: UIButton!
    @IBOutlet weak var changePassBTN: UIButton!
    @IBOutlet weak var changeEmailBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftNavigationMenu") as! UISideMenuNavigationController
        
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        changeProfileBTN.layer.cornerRadius = 15
        changePassBTN.layer.cornerRadius = 15
        changeEmailBTN.layer.cornerRadius = 15
    }
    
    @IBAction func sideMenu(_ sender: UIButton) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }

}
