//
//  GroceryCategoryResponseDTO+ Ext.swift
//  Grocery
//
//  Created by RUMEN GUIN on 26/05/23.
//

import Foundation
import GroceryAppSharedDTO

extension GroceryCategoryResponseDTO: Identifiable, Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: GroceryCategoryResponseDTO, rhs: GroceryCategoryResponseDTO) -> Bool {
        return lhs.id == rhs.id
    }
    
}
