//
//  DataManager.swift
//  SwitcHome
//
//  Created by José Manuel Rivera García on 22/1/18.
//  Copyright © 2018 DomoticSolutions. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    func getLogin(params: [String: Any], headers: [String: String], completionHandler: @escaping (_ json: JSONhttp) -> Void){
        let requestController = RequestController()
        let url: URL = URL(string:"http://h2744356.stratoserver.net/domotics/serverIoTApi/public/index.php/users/login.json")!
        
        requestController.makeGetRequest(url: url, params: params, headers: headers) { (json) in
            
            completionHandler(json)
        }

    }
    
    func postCreateUser(params: [String: Any], headers: [String: String], completionHandler: @escaping (_ json: JSONhttp) -> Void){
        let requestController = RequestController()
        let url: URL = URL(string:"http://h2744356.stratoserver.net/domotics/serverIoTApi/public/index.php/users/create.json")!
        
            requestController.makePostRequest(url: url, params: params, headers: headers, completionHandler: {(json) in
                
                    completionHandler(json)
            })
    }

}
