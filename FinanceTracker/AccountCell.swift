//
//  AccountCell.swift
//  FinanceTracker
//
//  Created by Valentin Drelon on 12/01/2023.
//

import SwiftUI

struct AccountCell: View {
    
    @ObservedObject var account: Account
    
    var body: some View {
        HStack {
            Image(account.iconName)
                .resizable()
                .padding(4)
                .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 4) {
                Text(account.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("Solde : \(String(format: "%.2f", account.amount)) €")
                    .font(.footnote)
                    .foregroundColor(Color(white: 0.4))
            }
            Spacer()
            Button {
                account.isFavourite.toggle()
            } label: {
                Image(systemName: account.isFavourite ? "star.fill" : "star")
                    .foregroundColor(account.isFavourite ? .yellow : Color(white: 0.4))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }
}

struct AccountCell_Previews: PreviewProvider {
    
    static let previewAccount = Account(iconName: "icon_002",
                                        name: "PayPal",
                                        initialAmount: 3259.60,
                                        transactions: previewTransactions,
                                        currency: .euro)
    
    static var previews: some View {
        AccountCell(account: previewAccount)
    }
}
