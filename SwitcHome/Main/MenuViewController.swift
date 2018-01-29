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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
            
            navigationController?.popToRootViewController(animated: false)
//            performSegue(withIdentifier: "goToMain", sender: nil)
//            let rootViewController = self.storyboard!.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
//            let navController = UINavigationController(rootViewController: rootViewController) // Creating a navigation controller with VC1 at the root of the navigation stack.
//            self.present(navController, animated:true, completion: nil)
        }else if indexPath.row == menuText.count-1 {
            UserDefaults.standard.set("" , forKey: "token")
            performSegue(withIdentifier: "exitToLogin", sender: nil)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
