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
                completionHandler(JSONhttp(code: 419, message: "No se ha podido conectar con el servidor, pruebe mas tarde", data: [:]) )
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
                completionHandler(JSONhttp(code: 419, message: "No se ha podido conectar con el servidor, pruebe mas tarde", data: [:]) )
            }
        })
    }
    
    func makePostRequestMultipart(url: URL, params: Parameters, headers: HTTPHeaders, image: UIImage?, completionHandler: @escaping (_ json: JSONhttp) -> Void){
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                
                if image != nil {
                    
                    multipartFormData.append(UIImageJPEGRepresentation(image!, 0.1)!, withName: "photo", fileName: "profileimage.jpeg", mimeType: "image/jpeg")
                }
                for (key, value) in params
                {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to: url ,headers: headers)
        { (result) in
            switch result {
            case .success(let upload,_,_ ):
                upload.responseJSON
                    { resp in
                        var requestResponse: JSONhttp = JSONhttp()
                        
                        if resp.result.value != nil{
                            let json = resp.result.value as! NSDictionary
                            requestResponse = JSONhttp(json: json as! [String : Any])
                            completionHandler(requestResponse)
                        }else{
                            completionHandler(JSONhttp(code: 419, message: "No se ha podido conectar con el servidor, pruebe mas tarde", data: [:]) )
                        }
                }
            case .failure( _):
                break
            }
        }
    }
}
