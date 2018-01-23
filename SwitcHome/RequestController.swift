//
//  RequestController.swift
//  SwitcHome
//
//  Created by José Manuel Rivera García on 22/1/18.
//  Copyright © 2018 DomoticSolutions. All rights reserved.
//

import UIKit
import Alamofire

class RequestController: NSObject {
    
    
    func makeGetRequest(url: URL, params: Parameters, headers: HTTPHeaders, completionHandler: @escaping (_ json: JSONhttp) -> Void){
        Alamofire.request(url ,method: .get ,parameters: params, headers: headers).responseJSON(completionHandler: { (resp: DataResponse<Any>) in
            var requestResponse: JSONhttp = JSONhttp()
            
            if resp.result.value != nil{
                    let json = resp.result.value as! NSDictionary
                    requestResponse = JSONhttp(json: json as! [String : Any])
                    completionHandler(requestResponse)
            }else{
                completionHandler(JSONhttp(code: 500, message: "No se ha podido conectar con el servidor, pruebe mas tarde", data: [:]) )
            }
        })
    }
    
    func makePostRequest(url: URL, params: Parameters, headers: HTTPHeaders, completionHandler: @escaping (_ json: JSONhttp) -> Void){
        
        Alamofire.request(url ,method: .post ,parameters: params, headers: headers).responseJSON(completionHandler: { (resp: DataResponse<Any>) in
            var requestResponse: JSONhttp = JSONhttp()
            
            if resp.result.value != nil{
                let json = resp.result.value as! NSDictionary
                requestResponse = JSONhttp(json: json as! [String : Any])
                completionHandler(requestResponse)
            }else{
                completionHandler(JSONhttp(code: 500, message: "No se ha podido conectar con el servidor, pruebe mas tarde", data: [:]) )
            }
        })
    }
}
