//
//  FunctionsViewController.swift
//  SwitcHome
//
//  Created by José Manuel Rivera García on 29/1/18.
//  Copyright © 2018 DomoticSolutions. All rights reserved.
//

import UIKit
import SideMenu
import ZAlertView

class FunctionsViewController: UIViewController {

    @IBOutlet weak var appFollowBTN: UIButton!
    @IBOutlet weak var appStyleBTN: UIButton!
    @IBOutlet weak var resetBTN: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkStyle()
        checkFollow()
        
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftNavigationMenu") as! UISideMenuNavigationController
        
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        resetBTN.layer.cornerRadius = 10
    }

    @IBAction func sideMenu(_ sender: Any) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    @IBAction func resetAction(_ sender: UIButton) {
        buildAndShowPopUp()
    }
    
    func buildAndShowPopUp() {
        //Se crea el alert con un estilo y se muestra
        ZAlertView.positiveColor = #colorLiteral(red: 0.8538075089, green: 0.01684000529, blue: 0.1194023266, alpha: 1)
        ZAlertView.negativeColor = #colorLiteral(red: 0.009957599454, green: 0.59536165, blue: 0.981543839, alpha: 1)
        ZAlertView.messageColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        ZAlertView.titleColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        
        let dialog = ZAlertView(title: "Reiniciar el sistema", message: "¿Estas seguro de que quieres reiniciar el sistema?", isOkButtonLeft: false, okButtonText: "REINICIAR", cancelButtonText: "CANCELAR", okButtonHandler: { (alert) in
            //Llamar a la API para reiniciar la raspberry
        }) { (alert) in
            alert.dismissAlertView()
        }
        dialog.show()
    }
    
    @IBAction func swapAppStyle(_ sender: UIButton) {
        let appStyle = UserDefaults.standard.value(forKey: "appStyle") as! String
        if appStyle == "night" {
            UserDefaults.standard.set("day", forKey: "appStyle")
            appStyleBTN.setImage( #imageLiteral(resourceName: "iconosAppSwitchomeOFF"), for: .normal)
        }else if appStyle == "day"{
            UserDefaults.standard.set("night", forKey: "appStyle")
            appStyleBTN.setImage(#imageLiteral(resourceName: "iconosAppSwitchome"), for: .normal)
        }
    }
    func checkStyle() {
        let appStyle = UserDefaults.standard.value(forKey: "appStyle") as! String
        if appStyle == "night" {
            appStyleBTN.setImage( #imageLiteral(resourceName: "iconosAppSwitchome"), for: .normal)
        }else if appStyle == "day"{
            appStyleBTN.setImage(#imageLiteral(resourceName: "iconosAppSwitchomeOFF"), for: .normal)
        }
    }
    
    @IBAction func sliderVolume(_ sender: UISlider) {
        //Slider del volumen
    }
    
    @IBAction func swapAppFollow(_ sender: UIButton) {
        let follow = UserDefaults.standard.value(forKey: "follow") as! Bool
        if follow == true {
            UserDefaults.standard.set(false, forKey: "follow")
            appFollowBTN.setImage( #imageLiteral(resourceName: "sensorIconOFF"), for: .normal)
        }else if follow == false{
            UserDefaults.standard.set(true, forKey: "follow")
            appFollowBTN.setImage(#imageLiteral(resourceName: "sensorIcon"), for: .normal)
        }
    }
    
    func checkFollow() {
        let follow = UserDefaults.standard.value(forKey: "follow") as! Bool
        if follow == true {
            appFollowBTN.setImage( #imageLiteral(resourceName: "sensorIcon"), for: .normal)
        }else if follow == false{
            appFollowBTN.setImage(#imageLiteral(resourceName: "sensorIconOFF"), for: .normal)
        }
    }
    
}
