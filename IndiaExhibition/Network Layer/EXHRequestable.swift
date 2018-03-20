//
//  EXHRequestable.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/19/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import Foundation

enum HttpType:String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Notifiable:class {
    func didLoadData(model:Any?, info:Any?, error:Error?)
}

/*
 All request model should comfirm this protocol
 */
protocol EXHRequestable {
    var basePath:String? {get}
    var apiPath:String? {set get}
    var httpType:HttpType {set get}
    var pathType :EXHPostServicePath? {get set}
    var modelType:Identifiable.Type? {get}
    var queryParams:[String:String]? {get set}
}


// MARK: - Protocol is extended with common functionality methods like basePath. In addition to that, protocol extension contains some generic methods like requestURL and httpHeaders etc.
extension EXHRequestable {
    
    var basePath:String? {
        return EXHConfigEndPoints.shared.appMode.baseEndPoint()
    }
    
    func requestURL()->URL? {
        
        if let path = self.basePath,
            let api = self.apiPath {
            let fullPath = path+api
            var fullQuery = ""
            
            if let dict = self.queryParams {
                
                for (key, value) in dict {
                    if fullQuery == "" {
                        fullQuery += "?"+key+"="+value
                    }
                    else {
                        fullQuery += "&"+key+"="+value
                    }
                }
            }
            
            let finalPath = fullPath+fullQuery
            
            return URL(string: finalPath)
        }
        
        return nil
    }
    
    func httpHeaders()->[String:String]? {
        
        var dict:[String:String] = [:]
        dict["Content-Type"] = "application/json"
        return dict
    }
}



protocol ViewModelParams {
    
    func apiCallWithType(type:EXHPostServicePath)
}

struct UsersEnvelop:EXHRequestable {
    var apiPath:String?
    var httpType:HttpType
    var pathType :EXHPostServicePath?
    var modelType:Identifiable.Type? {return nil}
    var queryParams:[String:String]?
}

struct EXHUser:Decodable {
    let id:Int
    let first_name:String
    let last_name:String
    let display_name:String
    let bio:String
    let gravatar:String
    let location:String
    let social:[String:String]
    let sets:String
}
