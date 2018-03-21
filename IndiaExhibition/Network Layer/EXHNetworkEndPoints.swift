//
//  EXHNetworkEndPoints.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/19/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import Foundation

struct EXHNetworkEndPoints {
    
    static func getDevBaseURL()->String {
        return "http://indiaexhibitionevents.com"
    }
    
    static func getProductionBaseURL()->String {
        return "http://indiaexhibitionevents.com"
    }
    
    static func users(userId:String?=nil)->String {
        
        var path = "/api/v1/users/"
        if let id = userId {
            path += id+"/";
        }
        
        return path
    }
    
    static func voices(userId:String?=nil)->String {
        
        var path = "/api/v1/voices/"
        if let id = userId {
            path += id+"/";
        }
        
        return path
    }
    
    static func sets(userId:String?=nil)->String {
        
        var path = "/api/v1/sets/"
        if let id = userId {
            path += id+"/";
        }
        
        return path
    }
    
    
    
}
