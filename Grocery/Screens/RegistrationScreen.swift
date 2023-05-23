//
//  RegistrationScreen.swift
//  Grocery
//
//  Created by RUMEN GUIN on 23/05/23.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @EnvironmentObject private var model: GroceryModel
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && (password.count >= 6 && password.count <= 10)
    }
    
    private func register() async {
        
        do {
            let registerResponseDTO = try await model.register(username: username, password: password)
            if !registerResponseDTO.error {
                // take the user to the login screen
            }else {
                //display error
                errorMessage = registerResponseDTO.reason ?? ""
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        
    }
    
    var body: some View {
        Form {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            
            HStack {
                Button("Register") {
                    Task {
                        await register()
                    }
                }
                .buttonStyle(.borderless)
                .disabled(!isFormValid)
            }
            Text(errorMessage)
        }
        .navigationTitle("Registration")
    }
}

struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            RegistrationScreen()
                .environmentObject(GroceryModel())
        }
    }
}
