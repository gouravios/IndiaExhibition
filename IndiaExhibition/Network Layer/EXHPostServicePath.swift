//
//  EXHPostServicePath.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/19/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import Foundation

protocol ParameterBodyMaker {
    func httpBodyEnvelop()->[String:Any]?
    func encodeBodyEnvelop() throws -> Data?
}


/*
 ALL services post dictionary is mentioned under enum switch statement.
 These cases get their values in ViewController (or respective controller or other class).
 This enum also wrap a method which provides dictionary for post body.
 */
internal enum EXHPostServicePath:ParameterBodyMaker {
    
    case login(username:String, password:String,signType:String,uniqueId:String)
    case registration(first_name:String, last_name:String, email:String, pass:String, deviceid:String,phone:String)
    
    func httpBodyEnvelop()->[String:Any]? {
        
        switch self {
        case .login(username: let user, password: let pwd, signType: let type,uniqueId: let uniqueId):
            
            let postBody = ["UserId":user, "Password":pwd, "UserType":type,"UniqueId":uniqueId]
            return postBody
            
        case .registration(first_name: let fname, last_name: let lname, email: let email, pass: let password, deviceid: let did, phone: let ph):
            let postBody = ["first_name":fname,"last_name":lname,"email":email,"pass":password,"deviceid":did,"phone":ph]
            
            return postBody
        }
    }
    
    func encodeBodyEnvelop() throws -> Data? {
        
        do {
            if let body = self.httpBodyEnvelop() {
                let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
                return data
            }
        }
        catch  {
            throw error
        }
        
        return nil
    }
    
}
