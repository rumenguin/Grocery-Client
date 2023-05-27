//
//  GroceryItemListView.swift
//  Grocery
//
//  Created by RUMEN GUIN on 27/05/23.
//

import SwiftUI
import GroceryAppSharedDTO

struct GroceryItemListView: View {
    
    let groceryItems: [GroceryItemResponseDTO]
    let onDelete: (UUID) -> Void
    
    private func deleteGroceryItem(at offsets: IndexSet) {
        offsets.forEach { index in
            let groceryItem = groceryItems[index]
            onDelete(groceryItem.id)
        }
    }
    
    var body: some View {
        List {
            ForEach(groceryItems) { groceryItem in
                Text(groceryItem.title)
            }
            .onDelete(perform: deleteGroceryItem)
        }
    }
}

struct GroceryItemListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryItemListView(groceryItems: [], onDelete: { _ in })
    }
}
