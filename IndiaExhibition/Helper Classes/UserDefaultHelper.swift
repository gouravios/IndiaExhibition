
//
//  UserDefaultHelper.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/21/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys : String {
        
        case isLoggedIn
    }
    
    func setIsLoggedIn(value : Bool)  {
        
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
}
