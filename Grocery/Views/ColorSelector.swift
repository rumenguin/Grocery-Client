//
//  ColorSelector.swift
//  Grocery
//
//  Created by RUMEN GUIN on 25/05/23.
//

import SwiftUI

enum Colors: String, CaseIterable {
    case blue = "#212834"
    case green = "#2ecc71"
    case red = "#e74c3c"
    case purple = "#9b59b6"
    case yellow = "#f1c40f"
}

struct ColorSelector: View {
    
    @Binding var colorCode: String
    
    var body: some View {
        HStack {
            ForEach(Colors.allCases, id: \.rawValue) { color in
                VStack {
                    Image(systemName: colorCode == color.rawValue ? "record.circle.fill" : "circle.fill")
                        .font(.title)
                        .foregroundColor(Color.fromHex(color.rawValue))
                        .clipShape(Circle())
                        .onTapGesture {
                            colorCode = color.rawValue
                        }
                    
                }
            }
        }
    }
}

struct ColorSelector_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelector(colorCode: .constant("#212834"))
    }
}
