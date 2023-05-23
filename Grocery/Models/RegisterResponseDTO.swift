//
//  RegisterResponseDTO.swift
//  Grocery
//
//  Created by RUMEN GUIN on 23/05/23.
//

import Foundation

struct RegisterResponseDTO: Codable {
    let error: Bool
    var reason: String? = nil
}
