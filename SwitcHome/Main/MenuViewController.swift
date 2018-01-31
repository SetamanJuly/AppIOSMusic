//
//  MenuViewController.swift
//  SwitcHome
//
//  Created by José Manuel Rivera García on 26/1/18.
//  Copyright © 2018 DomoticSolutions. All rights reserved.
//

import UIKit
import SideMenu

class MenuViewController: UITableViewController {
    var menuText: [String] = ["Inicio", "Funciones rápidas", "Mis dispositivos", "Mis configuraciones", "Mi perfil", "Cerrar sesión"]
    let bgColorView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgColorView.backgroundColor = #colorLiteral(red: 0.009957599454, green: 0.59536165, blue: 0.981543839, alpha: 1)
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return menuText.count/menuText.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuText.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuViewCell
        cell.menuText.text = menuText[indexPath.row]
        
        cell.selectedBackgroundView = bgColorView;
        if indexPath.row == menuText.count-1 {
            cell.menuText.textColor = #colorLiteral(red: 1, green: 0.1568467882, blue: 0, alpha: 1)
        }


        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            mainNavigationController.popToRootViewController(animated: false)
            dismiss(animated: true, completion: nil)
            
        }else if indexPath.row == 1 {

            mainNavigationController.popToRootViewController(animated: false)
            mainNavigationController.performSegue(withIdentifier: "goToFunctions", sender: nil)
            dismiss(animated: true, completion: nil)

        }else if indexPath.row == 2{
            
            mainNavigationController.popToRootViewController(animated: false)
//            Ir a Mis dispositivos
//            mainNavigationController.performSegue(withIdentifier: "", sender: nil)
            dismiss(animated: true, completion: nil)
            
        }else if indexPath.row == 3{
            
            mainNavigationController.popToRootViewController(animated: false)
//            Ir a mis configuraciones
//            mainNavigationController.performSegue(withIdentifier: "", sender: nil)
            dismiss(animated: true, completion: nil)
            
        }else if indexPath.row == 4{

            mainNavigationController.popToRootViewController(animated: false)
            mainNavigationController.performSegue(withIdentifier: "goToProfile", sender: nil)
            dismiss(animated: true, completion: nil)
            
        }else if indexPath.row == menuText.count-1 {
            UserDefaults.standard.set("" , forKey: "token")
            performSegue(withIdentifier: "exitToLogin", sender: nil)
        }
    }
   
}
