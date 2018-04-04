//
//  EXHLoginViewModel.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/19/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import Foundation

enum LoginError : Error {
    case inCompleteForm
    case invalidEmail
}

class EXHLoginViewModel  {

    lazy var webservice = EXHWebAPIWrapper()
    var userInfo:UserInfo?
    var username: String = ""
    var password: String = ""
    
    func apiCallWithType(type : EXHPostServicePath, completionHandler :@escaping (Bool,Error)->()) {
        
        let envelop = EXHUserInfoRequest(apiPath: "/api/Login", httpType: HttpType.post, pathType: type, queryParams:[:])
        
        webservice.callServiceWithRequest(objRequestable: envelop) { (info:Any?, err:Error?) in
            
            if let result = info as? ResponseResult<Any> {
                
                if let resultValue = result.value as? UserInfo {
                    self.userInfo = resultValue
                    completionHandler(true,result.error!)
                } else {
                    
                    completionHandler(false,result.error!)
                    
                }
            } else {
                
                 completionHandler(false,err!)
            }
        }
    }
   
}

extension EXHLoginViewModel {
    
     func updateUsername(username: String) {
        self.username = username
     }
    
     func updatePassword(password: String) {
        self.password = password
     }
    
    func login () throws  {
        
        if self.username.isEmpty || self.password.isEmpty  {
            
            throw LoginError.inCompleteForm
            
        } else if !username.isValidEmail {
            
            throw LoginError.invalidEmail
        }
    }
}





