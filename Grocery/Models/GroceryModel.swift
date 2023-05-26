//
//  GroceryModel.swift
//  Grocery
//
//  Created by RUMEN GUIN on 23/05/23.
//

import Foundation
import GroceryAppSharedDTO

@MainActor
class GroceryModel: ObservableObject {
    
    @Published var groceryCategories: [GroceryCategoryResponseDTO] = []
    
    let httpClient = HTTPClient()
    
    func register(username: String, password: String) async throws -> RegisterResponseDTO {
        
        let registerData = ["username": username, "password": password]
        
        let resource = try Resource(url: Constants.Urls.register, method: .post(JSONEncoder().encode(registerData)), modelType: RegisterResponseDTO.self)
        
        let registerResponseDTO = try await httpClient.load(resource)
        return registerResponseDTO
        
    }
    
    func login(username: String, password: String) async throws -> LoginResponseDTO {
        
        let loginPostData = ["username": username, "password": password]
        
        //resource
        let resource = try Resource(url: Constants.Urls.login, method: .post(JSONEncoder().encode(loginPostData)), modelType: LoginResponseDTO.self)
        
        let loginResponseDTO = try await httpClient.load(resource)
        
        if !loginResponseDTO.error && loginResponseDTO.token != nil && loginResponseDTO.userId != nil{
            
            //save the token in user defaults
            let defaults = UserDefaults.standard
            defaults.set(loginResponseDTO.token!, forKey: "authToken")
            defaults.set(loginResponseDTO.userId!.uuidString, forKey: "userId")
        }
        
        return loginResponseDTO
    }
    
    func deleteGroceryCategory(groceryCategoryId: UUID) async throws {
        
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        
        let resource = Resource(url: Constants.Urls.deleteGroceryCategory(userId: userId, groceryCategoryId: groceryCategoryId), method: .delete, modelType: GroceryCategoryResponseDTO.self)
        
        let deleteGroceryCategory = try await httpClient.load(resource)
        
        //remove the deleted category from the list
        groceryCategories = groceryCategories.filter { $0.id != deleteGroceryCategory.id }
        
    }
    
    func populateGroceryCategories() async throws {
        
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        
        let resource = Resource(url: Constants.Urls.groceryCategoriesBy(userId: userId), modelType: [GroceryCategoryResponseDTO].self)
        
        groceryCategories = try await httpClient.load(resource)
        
    }
    
    func saveGroceryCategory(_ groceryCategoryRequestDTO: GroceryCategoryRequestDTO) async throws {
        
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        
        let resource = try Resource(url: Constants.Urls.saveGroceryCategory(userId: userId), method: .post(JSONEncoder().encode(groceryCategoryRequestDTO)), modelType: GroceryCategoryResponseDTO.self)
        
        let groceryCategory = try await httpClient.load(resource)
        
        //add new grocery to the list
        groceryCategories.append(groceryCategory)
    }
    
}
