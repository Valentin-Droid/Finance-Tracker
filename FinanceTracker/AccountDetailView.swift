//
//  AccountDetailView.swift
//  FinanceTracker
//
//  Created by Valentin Drelon on 17/01/2023.
//

import SwiftUI

struct AccountDetailView: View {
    
    @ObservedObject var account: Account
    @State private var isPresentingNewTransactionScreen = false
    @State var isShowingAlert = false
    @State var isShowingTransactionAlert = false
    @State var isEditingMode = false
    @EnvironmentObject var accountsList: AccountsList
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTransactionToDelete: Transaction? = nil
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                HStack {
                    if isEditingMode {
                        TextField("Entrez un nom...", text: $account.name)
                            .font(.system(size: 32, weight: .bold))
                            .focused($focusedField, equals: .name)
                    } else {
                        Text(account.name)
                            .font(.system(size: 32, weight: .bold))
                    }
                    Spacer()
                    Text("\(String(format: "%.2f", account.amount)) \(account.currency.rawValue)")
                        .font(.system(size: 32, weight: .light))
                }
                AccentButton(title: "+ transaction", color: Color.violet) {
                    isPresentingNewTransactionScreen = true
                }
                Divider()
                VStack(spacing: 16) {
                    if account.transactions.isEmpty {
                        Text("Aucune transaction pour le moment...")
                            .font(.callout)
                            .foregroundColor(Color(white: 0.4))
                    }
                    ForEach(account.transactions) { transaction in
                        TransactionCell(transaction: transaction, ondDelete: {
                            isShowingTransactionAlert = true
                            selectedTransactionToDelete = transaction
                        })
                    }
                    Text("Solde initial : \(String(format: "%.2f", account.initialAmount)) \(account.currency.rawValue)")
                        .font(.callout)
                        .foregroundColor(Color(white: 0.4))
                        .padding()
                }
            }
            .padding()
        }
        .background(Color.grey)
        .sheet(isPresented: $isPresentingNewTransactionScreen, content: {
            NewTransactionView()
        })
        .toolbar {
            Menu {
                Button {
                    isEditingMode = true
                    focusedField = .name
                } label: {
                    Label("Renommer", systemImage: "pencil")
                }
                Button(role: .destructive) {
                    isShowingAlert = true
                } label: {
                    Label("Supprimer", systemImage: "trash")
                }
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(.primary)
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("Attends !"),
                    message: Text("Es-tu sûr de vouloir supprimer ce compte ? Toutes les transactions liées seront perdues."),
                    primaryButton: .destructive(Text("Supprimer"), action: {
                        accountsList.accounts.removeAll { element in
                            element.id == account.id
                        }
                        presentationMode.wrappedValue.dismiss()
                    }),
                    secondaryButton: .cancel(Text("Annuler")))
            }
        }
        .alert(isPresented: $isShowingTransactionAlert) {
            Alert(
                title: Text("Hmm..."),
                message: Text("Tu es sur le point de supprimer la transaction . Cette transaction sera perdue à jamais."),
                primaryButton: .destructive(Text("Supprimer"), action: {
                    withAnimation {
                        account.transactions.removeAll { transaction in
                            selectedTransactionToDelete!.id == transaction.id
                        }
                    }
                    selectedTransactionToDelete = nil
                }),
                secondaryButton: .cancel(Text("Annuler"))
            )
        }
    }
    private enum Field: Int, Hashable {
        case name
    }
}

struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountDetailView(account: previewAccounts[0])
        }
    }
}
