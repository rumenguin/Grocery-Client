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
    @StateObject private var appState = AppState()
    var body: some Scene {
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "authToken")
        
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                
                Group {
                    if token == nil {
                        RegistrationScreen()
                    }else {
                        GroceryCategoryListScreen()
                    }
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                        case .register:
                            RegistrationScreen()
                        case .login:
                            LoginScreen()
                        case .groceryCategoryList:
                            GroceryCategoryListScreen()
                        case .groceryCategoryDetail(let groceryCategory):
                            GroceryDetailScreen(groceryCategory: groceryCategory)
                    }
                }
            }
            .environmentObject(model)
            .environmentObject(appState)
        }
    }
}
