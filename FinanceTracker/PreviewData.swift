//
//  PreviewData.swift
//  FinanceTracker
//
//  Created by Valentin Drelon on 12/01/2023.
//

import Foundation

let previewTransactions = [
    Transaction(label: "Repas du midi", amount: 8.54, currency: .euro, date: Date()),
    Transaction(label: "Tickets de métro", amount: 16.50, currency: .euro, date: Date()),
    Transaction(label: "Loyer", amount: 745, currency: .euro, date: Date())
]

let previewAccounts = [
    Account(iconName: "icon_002", name: "PayPal", initialAmount: 289.56, transactions: previewTransactions, currency: .euro),
    Account(iconName: "icon_007", name: "Binance", initialAmount: 3656.54, transactions: previewTransactions, currency: .dollar),
    Account(iconName: "icon_001", name: "Bourso", initialAmount: 2718.45, transactions: previewTransactions, currency: .yen)
]
