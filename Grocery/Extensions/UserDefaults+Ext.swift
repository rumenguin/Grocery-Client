//
//  UserDefaults+Ext.swift
//  Grocery
//
//  Created by RUMEN GUIN on 25/05/23.
//

import Foundation

extension UserDefaults {
    
    var userId: UUID? {
        get {
            guard let userIdAsString = string(forKey: "userId") else {
                return nil
            }
            return UUID(uuidString: userIdAsString)
        }
        
        set {
            set(newValue?.uuidString, forKey: "userId")
        }
    }
    
}
