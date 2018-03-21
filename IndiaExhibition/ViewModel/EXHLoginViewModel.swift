//
//  EXHLoginViewModel.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/19/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import Foundation



class EXHLoginViewModel : ViewModelParams {
  
    weak var delegate:Notifiable?
    lazy var webservice = EXHWebAPIWrapper()
    var userInfo:UserInfo?
    
    func apiCallWithType(type:EXHPostServicePath) {
        
       
        let envelop = EXHUserInfoRequest(apiPath: "/api/Login", httpType: HttpType.post, pathType: type, queryParams:[:])
        
        webservice.callServiceWithRequest(objRequestable: envelop) { (info:Any?, err:Error?) in
            
            if let result = info as? ResponseResult<Any> {
                
               if let resultValue = result.value as? UserInfo {
                    self.userInfo = resultValue
                    self.delegate?.didLoadData(model: self, info: nil, error: result.error)
                }
               return
            }
            self.delegate?.didLoadData(model: self, info: nil, error: err)
        }
    }
}
