//
//  LoginViewModel.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/19/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import Foundation


struct YMHVoiceUserRequest:EXHRequestable {
    
    var fullPath:(full:String?,base:String?,relative:String?)
    var basePath: String? {
        return fullPath.base
    }
    
    var apiPath:String?
    var httpType:HttpType
    var pathType :EXHPostServicePath?
    var modelType:Identifiable.Type? {
        return UserInfo.self
    }
    var queryParams:[String:String]?
    
    init(userPath:String,type:HttpType,pType:EXHPostServicePath?=nil) throws {
        
        if let urlPath = URL(string:userPath), let scheme = urlPath.scheme
            , let host = urlPath.host, urlPath.relativePath != "" {
            
            let basePath = scheme+"://"+host
            apiPath = urlPath.relativePath
            fullPath = (userPath, basePath, apiPath)
        }
        else {
            throw APIErrorType.apiMessage(key: "detail", message: "Wrong Parameter Types")
        }
        
        httpType = type
        pathType = pType
    }
}



protocol ViewModelParams {
    
    func apiCallWithType(type:EXHPostServicePath)
}

protocol Notifiable:class {
    
    func didLoadData(model:Any?, info:Any?, error:Error?)
}

class EXHLoginViewModel : ViewModelParams, Notifiable {
  
    
    func didLoadData(model: Any?, info: Any?, error: Error?) {
        
    }
    
    
    weak var delegate:Notifiable?
    lazy var webservice = EXHWebAPIWrapper()
    
    func apiCallWithType(type:EXHPostServicePath) {
        
        
    }
    
  
    
}
