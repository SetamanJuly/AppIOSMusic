//
//  DataManager.swift
//  SwitcHome
//
//  Created by José Manuel Rivera García on 22/1/18.
//  Copyright © 2018 DomoticSolutions. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    func getLogin(params: [String: Any], completionHandler: @escaping (_ json: JSONhttp) -> Void){
        let requestController = RequestController()
        
        let url: URL = URL(string:"http://h2744356.stratoserver.net/domotics/serverIoTApi/public/index.php/users/login.json")!
        
        requestController.makeGetRequest(url: url, params: params, headers: [:]) { (json) in
            completionHandler(json)
        }
    }
    
    func postCreateUser(params: [String: Any], completionHandler: @escaping (_ json: JSONhttp) -> Void){
        let requestController = RequestController()
        
        let url: URL = URL(string:"http://h2744356.stratoserver.net/domotics/serverIoTApi/public/index.php/users/create.json")!
        let headers: [String: String] = ["Content-Type": "application/x-www-form-urlencoded"]
        
        requestController.makePostRequest(url: url, params: params, headers: headers, completionHandler: {(json) in
                    completionHandler(json)
            })
    }
    
    func getRecoverPass(params: [String: Any], completionHandler: @escaping (_ json: JSONhttp) -> Void){
        let requestController = RequestController()
        
        let url: URL = URL(string:"http://h2744356.stratoserver.net/domotics/serverIoTApi/public/index.php/users/recover_pass.json")!
        
        requestController.makeGetRequest(url: url, params: params, headers: [:]) { (json) in
            completionHandler(json)
        }
    }
    
    func postUpdatePass(params: [String: Any], completionHandler: @escaping (_ json: JSONhttp) -> Void){
        let requestController = RequestController()
        
        let url: URL = URL(string:"http://h2744356.stratoserver.net/domotics/serverIoTApi/public/index.php/users/update_pass.json")!
        let headers: [String: String] = ["Content-Type": "application/x-www-form-urlencoded", "Authorization": UserDefaults.standard.value(forKey: "token") as! String]
        
        requestController.makePostRequest(url: url, params: params, headers: headers, completionHandler: {(json) in
            completionHandler(json)
        })
    }

    func getAuth(completionHandler: @escaping (_ json: JSONhttp) -> Void){
        let requestController = RequestController()
        
        let url: URL = URL(string:"http://h2744356.stratoserver.net/domotics/serverIoTApi/public/index.php/base/default_auth.json")!
        let headers: [String: String] = ["Authorization": UserDefaults.standard.value(forKey: "token") as! String]
        
        requestController.makeGetRequest(url: url, params: [:], headers: headers, completionHandler: {(json) in
            completionHandler(json)
        })
    }
}
