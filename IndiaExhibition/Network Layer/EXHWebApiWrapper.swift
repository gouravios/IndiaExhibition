//
//  EXHWebApiWrapper.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/19/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import Foundation


class EXHWebAPIWrapper {
    
    func callServiceWithRequest(objRequestable:EXHRequestable) {
        
        if let url4 = objRequestable.requestURL() {
            let session4 = URLSession.shared
            let request = NSMutableURLRequest(url: url4)
            
            request.httpMethod = objRequestable.httpType.rawValue
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            request.allHTTPHeaderFields = objRequestable.httpHeaders()
            
            do {
                request.httpBody = try objRequestable.pathType?.encodeBodyEnvelop()
                
                let task = session4.dataTask(with: request as URLRequest) { (data, response, error) in
                    guard let _: Data = data, let _: URLResponse = response, error == nil else {
                        return
                    }
                    
                    _ = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                   
                }
                
                task.resume()
            }
            catch  {
            }
        }
    }
    
    func callServiceWithRequest(objRequestable:EXHRequestable, completion:@escaping (Any?,Error?)->Void) {
        
        if let url4 = objRequestable.requestURL() {
            let session4 = URLSession.shared
            let request = NSMutableURLRequest(url: url4)
            request.httpMethod = objRequestable.httpType.rawValue
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            request.allHTTPHeaderFields = objRequestable.httpHeaders()
            
            do {
                request.httpBody = try objRequestable.pathType?.encodeBodyEnvelop()
                
                let task = session4.dataTask(with: request as URLRequest) { (data, response, error) in
                    
                    guard let _: Data = data, let _: URLResponse = response, error == nil else {
                        completion(data,error)
                        return
                    }
                    
                    if let cls = objRequestable.modelType {
                        let list = cls.parseJSON(data: data)
                        completion(list,error)
                        return
                    }
                    
                    completion(data,error)
                }
                
                task.resume()
            }
            catch  {
            }
        }
    }
}

