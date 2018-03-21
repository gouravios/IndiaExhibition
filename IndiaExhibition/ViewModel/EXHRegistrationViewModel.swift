//
//  EXHRegistrationViewModel.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/20/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import Foundation

class EXHRegistrationViewModel: ViewModelParams {
    
    
    weak var delegate:Notifiable?
    lazy var webservice = EXHWebAPIWrapper()
    
    func apiCallWithType(type: EXHPostServicePath) {
     
           let envelop = UsersEnvelop(apiPath: "/api/Registration", httpType: HttpType.post, pathType: type, queryParams:[:])
        
         webservice.callServiceWithRequest(objRequestable: envelop) { (info:Any?, err:Error?) in
            
            if let result = info as? ResponseResult<Any> {
                
                if let resultValue = result.value as? UserInfo {
                   
                    self.delegate?.didLoadData(model: self, info: nil, error: result.error)
                }
                return
            }
            self.delegate?.didLoadData(model: self, info: nil, error: err)
        }
    }
}
