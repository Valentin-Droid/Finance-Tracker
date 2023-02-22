//
//  AccentButton.swift
//  FinanceTracker
//
//  Created by Valentin Drelon on 16/01/2023.
//

import SwiftUI

struct AccentButton: View {
    
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.black)
                .font(.callout)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(color)
                .cornerRadius(10)
        }
    }
}

struct AccentButton_Previews: PreviewProvider {
    static var previews: some View {
        AccentButton(title: "Test Button", color: .myOrange, action: {})
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
