//
//  GroceryApp.swift
//  Grocery
//
//  Created by RUMEN GUIN on 22/05/23.
//

import SwiftUI

@main
struct GroceryApp: App {
    @StateObject private var model = GroceryModel()
    var body: some Scene {
        WindowGroup {
            RegistrationScreen()
                .environmentObject(model)
        }
    }
}
