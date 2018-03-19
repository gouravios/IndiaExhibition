//
//  EXHConfigEndPoint.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/19/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import Foundation


/*
 This structure has member function to set the current build scheme. Current build scheme selected in XCode will be set into project info.plist key named as APP_ENV. This key is also mentioned under Build Setting
 where each schemes names are mentioned. All these name must be equal to the names as mentioned under the Enum of AppEnvMode.
 
 */
struct EXHConfigEndPoints {
    
    internal enum AppEnvMode:String {
        
        case Undefined = "Undefined"
        case Debug = "Debug"
        case Release = "Release"
        case Dev = "Exhibition_Dev"
        case Prod = "Exhibition_Prod"
        /*
         Set your project scheme base urls
         */
        func baseEndPoint()->String? {
            
            switch self {
            case .Debug, .Dev:
                return EXHNetworkEndPoints.getDevBaseURL()
            case .Prod, .Release:
                return EXHNetworkEndPoints.getProductionBaseURL()
            default:
                return EXHNetworkEndPoints.getDevBaseURL()
            }
        }
    }
    
    private var mode: AppEnvMode?
    static var shared = EXHConfigEndPoints()
    
    var appMode:AppEnvMode {
        get {
            return mode!
        }
    }
    
    /* This method need to be called when app launches. Ideal place to call this method at the very beginining of AppDelegate delegate method didFinishLaunching */
    mutating func initialize() {
        
        self.mode = .Undefined
        
        /* Value is captured from info.plist. Value in info.plist will come from User-Defined Variables APP_ENV */
        if let modeString = Bundle.main.infoDictionary?["APP_ENV"] as? String,
            let modeType = AppEnvMode(rawValue: modeString) {
            self.mode = modeType
        }
    }
}
