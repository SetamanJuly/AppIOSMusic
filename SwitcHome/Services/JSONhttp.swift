//
//  JSONhttp.swift
//  SwitcHome
//
//  Created by José Manuel Rivera García on 22/1/18.
//  Copyright © 2018 DomoticSolutions. All rights reserved.
//

import UIKit

class JSONhttp: NSObject {
    var code: Int = 0
    var message: String = ""
    var data: [String: Any] = [:]
    override init() {
        
    }
    init(json: [String: Any]) {
        code = json["code"] as! Int
        message = json["message"] as! String
        data = json["data"] as? [String: Any] ?? [:]
    }
    
    init(code: Int, message: String, data: [String: Any]) {
        self.code = code
        self.message = message
        self.data = data
    }
    
}
