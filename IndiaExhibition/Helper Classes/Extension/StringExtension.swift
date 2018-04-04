//
//  StringExtension.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 4/3/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import Foundation


extension String {
    
    var isValidEmail : Bool {
        
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: self)
    }
}


extension Bundle {
    
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
