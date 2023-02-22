//
//  MainButton.swift
//  FinanceTracker
//
//  Created by Valentin Drelon on 16/01/2023.
//

import SwiftUI

struct MainButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.black)
                .cornerRadius(.infinity)
        }
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        MainButton(title: "hello") {
            print("hello")
        }
    }
}
