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
        WindowGroup {
            NavigationStack(path: $appState.routes) {
                RegistrationScreen()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                            case .register:
                                RegistrationScreen()
                            case .login:
                                LoginScreen()
                            case .groceryCategoryList:
                                Text("Grocery View")
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
