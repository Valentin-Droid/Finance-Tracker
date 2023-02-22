//
//  TransactionCell.swift
//  FinanceTracker
//
//  Created by Valentin Drelon on 16/01/2023.
//

import SwiftUI

struct TransactionCell: View {
    
    @ObservedObject var transaction: Transaction
    @State private var isDetailedMode = false
    let ondDelete: () -> Void
    @State private var isEdititngMode = false
    @FocusState private var focusedField: Field?
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy à HH:mm"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    if isEdititngMode {
                        TextField("Ex: Repas du midi", text: $transaction.label)
                            .font(.headline)
                            .focused($focusedField, equals: .label)
                    } else {
                        Text(transaction.label)
                            .font(.headline)
                    }
                    Text(dateFormatter.string(from: transaction.date))
                        .font(.footnote)
                        .foregroundColor(Color(white: 0.4))
                }
                Spacer()
                Text("\(String(format: "%.2f", transaction.amount)) \(transaction.currency.rawValue)")
            }
            if isDetailedMode {
                HStack {
                    Button {
                        ondDelete()
                    } label: {
                        Text("Supprimer")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                    }
                    Button {
                        isEdititngMode = true
                        focusedField = .label
                    } label: {
                        Text("Renommer")
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .onTapGesture {
            withAnimation(.easeIn(duration: 0.2)) {
                isDetailedMode.toggle()
            }
        }
    }
    private enum Field: Int, Hashable {
        case label
    }
}

struct TransactionCell_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCell(transaction: previewTransactions[0], ondDelete: {})
            .padding(24)
            .background(Color.grey)
            .previewLayout(.sizeThatFits)
    }
}
