//
//  AccountCreationView.swift
//  FinanceTracker
//
//  Created by Valentin Drelon on 15/01/2023.
//

import SwiftUI

struct AccountCreationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var accountName: String = ""
    @State private var selectedIcon: String = "icon_001"
    @State private var amount: String = ""
    @State private var selectedCurrency: Currency = .euro
    var onAccountCreated: (Account) -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 16) {
                Text(accountName == "" ? "Nouveau compte" : accountName)
                    .font(.system(size: 32, weight: .bold))
                    .padding(.top, 32)
                Text("Solde : \(String(format: "%.2f", Float(amount) ?? 0.0)) \(selectedCurrency.rawValue)")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(Color(white: 0.4))
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            VStack(alignment: .leading) {
                Text("Nom")
                    .font(.title2)
                    .bold()
                TextField("Ex : PayPal...", text: $accountName)
                    .submitLabel(.done)
                    .padding(12)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .cornerRadius(.infinity)
            }
            VStack(alignment: .leading) {
                Text("Icône")
                    .font(.title2)
                    .bold()
                IconSelector(selectedIcon: $selectedIcon)
                    .padding(.horizontal, -16)
            }
            VStack(alignment: .leading) {
                Text("Solde initial")
                    .font(.title2)
                    .bold()
                HStack {
                    TextField("EX : 200 \(selectedCurrency.rawValue)", text: $amount)
                        .keyboardType(.numbersAndPunctuation)
                        .submitLabel(.done)
                        .padding(12)
                        .padding(.horizontal, 12)
                    CurrencySelector(selectedCurrency: $selectedCurrency)
                        .foregroundColor(Color.violet)
                        .padding(4)
                }
                .background(Color.white)
                .cornerRadius(.infinity)
            }
            Spacer()
            MainButton(title: "Crée") {
                let newAccount = Account(iconName: selectedIcon,
                                         name: accountName,
                                         initialAmount: Float(amount) ?? 0.0,
                                         transactions: [],
                                         currency: selectedCurrency)
                onAccountCreated(newAccount)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
        .background(Color.grey)
    }
}

struct AccountCreationView_Previews: PreviewProvider {
    static var previews: some View {
        AccountCreationView { _ in
            return
        }
    }
}
