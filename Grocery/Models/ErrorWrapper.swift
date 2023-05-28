//
//  ErrorWrapper.swift
//  Grocery
//
//  Created by RUMEN GUIN on 28/05/23.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id = UUID()
    let error: Error
    let guidance: String
}
