//
//  ErrorView.swift
//  Grocery
//
//  Created by RUMEN GUIN on 28/05/23.
//

import SwiftUI

struct ErrorView: View {
    
    let errorWrapper: ErrorWrapper
    
    var body: some View {
        VStack {
            Text("Error has occurred in the application.")
                .font(.headline)
                .padding([.bottom], 10)
            Text(errorWrapper.error.localizedDescription)
            Text(errorWrapper.guidance)
                .font(.caption)
        }
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    
    enum SampleError: Error {
        case operationFailed
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: ErrorWrapper(error: SampleError.operationFailed, guidance: "Operation has failed. Please try again later."))
    }
}
