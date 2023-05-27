//
//  AddGroceryItemScreen.swift
//  Grocery
//
//  Created by RUMEN GUIN on 27/05/23.
//

import SwiftUI
import GroceryAppSharedDTO

struct AddGroceryItemScreen: View {
    
    @State private var title: String = ""
    @State private var price: Double? = nil
    @State private var quantity: Int? = nil
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var model: GroceryModel
    
    private var isFormValid: Bool {
        guard let price = price,
              let quantity = quantity else {
            return false
        }
        return !title.isEmptyOrWhiteSpace && price > 0 && quantity > 0
    }
    
    private func saveGroceryItem() async {
        
        //get the selected grocery category
        guard let groceryCategory = model.groceryCategory,
              let price = price,
              let quantity = quantity
        else { return }
        
        let groceryItemRequestDTO = GroceryItemRequestDTO(title: title, price: price, quantity: quantity)
        
        do {
            try await model.saveGroceryItem(groceryItemRequestDTO, groceryCategoryId: groceryCategory.id)
            dismiss()
        }catch {
            print(error.localizedDescription)
        }
        
    }
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Price", value: $price, format: .currency(code: Locale.current.currencySymbol ?? ""))
            TextField("Quantity", value: $quantity, format: .number)
        }
        .navigationTitle("New Grocery Item")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    
                    Task {
                        await saveGroceryItem()
                    }
                    
                }
                .disabled(!isFormValid)
            }
        }
    }
}

struct AddGroceryItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddGroceryItemScreen()
                .environmentObject(GroceryModel())
        }
    }
}
