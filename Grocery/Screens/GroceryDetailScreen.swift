//
//  GroceryDetailScreen.swift
//  Grocery
//
//  Created by RUMEN GUIN on 27/05/23.
//

import SwiftUI
import GroceryAppSharedDTO

struct GroceryDetailScreen: View {
    
    let groceryCategory: GroceryCategoryResponseDTO
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: GroceryModel
    
    private func populateGroceryItems() async {
        do {
            try await model.populateGroceryItemsBy(groceryCategoryId: groceryCategory.id)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    private func deleteGroceryItem(groceryItemId: UUID) {
        Task {
            do {
                try await model.deleteGroceryItem(groceryCategoryId: groceryCategory.id, groceryItemId: groceryItemId)
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        VStack {
            if model.groceryItems.isEmpty {
                Text("No items found...")
            } else {
                GroceryItemListView(groceryItems: model.groceryItems, onDelete: deleteGroceryItem)
            }
        }
        .navigationTitle(groceryCategory.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add Grocery Item") {
                    isPresented = true
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                AddGroceryItemScreen()
            }
        }
        .onAppear{
            model.groceryCategory = groceryCategory
        }
        .task {
            await populateGroceryItems()
        }
    }
}

struct GroceryDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GroceryDetailScreen(groceryCategory: GroceryCategoryResponseDTO(id: UUID(), title: "Seafood", colorCode: "#212834"))
                .environmentObject(GroceryModel())
        }
    }
}
