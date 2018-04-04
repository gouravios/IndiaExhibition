//
//  Constants.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 4/3/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import Foundation


struct Constants {
    
    struct LoginTypes {
        static let Facebook = "F"
        static let Google = "G"
        static let Custom = "G"
    }
    
    struct CellIdentifiers {
        static let Blue = "BlueCellIdentifier"
        static let Large = "LargeCellIdentifier"
    }
    
    struct FontSizes {
        static let Large: Float = 14.0
        static let Small: Float = 10.0
    }
    
    struct AnimationDurations {
        static let Fast: TimeInterval = 1.0
        static let Medium: TimeInterval = 3.0
        static let Slow: TimeInterval = 5.0
    }
    
    struct SegueIdentifiers {
        static let Master = "MasterViewController"
        static let Detail = "DetailViewController"
    }
    
    struct ConditionAlerts {
        
         static let InCompleteForm = "Please fill out both email & password fields."
         static let InvalidEmail = "Please make sure format your email correctly."
        
    }
    
}
