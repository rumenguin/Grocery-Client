//
//  LoginScreen.swift
//  Grocery
//
//  Created by RUMEN GUIN on 24/05/23.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    @EnvironmentObject private var appState: AppState
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    
    private func login() async {
        do {
            let loginResponseDTO = try await model.login(username: username, password: password)
            if loginResponseDTO.error {
                //errorMessage = loginResponseDTO.reason ?? ""
                appState.errorWrapper = ErrorWrapper(error: GroceryError.login, guidance: loginResponseDTO.reason ?? "")
            }else {
                //take the user to grocery categories list screen
                appState.routes.append(.groceryCategoryList)
            }
        }catch {
            appState.errorWrapper = ErrorWrapper(error: error, guidance: error.localizedDescription)
        }
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            HStack {
                Button("Login") {
                    Task {
                        await login()
                    }
                }
                .buttonStyle(.borderless)
                .disabled(!isFormValid)
                Spacer()
                Button("Register") {
                    appState.routes.append(.register)
                }
                .buttonStyle(.borderless)
            }
            Text(errorMessage)
        }
        .navigationTitle("Login")
        .navigationBarBackButtonHidden(true)
        .sheet(item: $appState.errorWrapper) { errorWrapper in
            ErrorView(errorWrapper: errorWrapper)
                .presentationDetents([.fraction(0.25)])
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginScreen()
                .environmentObject(GroceryModel())
                .environmentObject(AppState())
        }
    }
}
