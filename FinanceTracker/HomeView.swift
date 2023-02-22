//
//  HomeView.swift
//  FinanceTracker
//
//  Created by Valentin Drelon on 11/01/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isPresentingNewAccountScreen: Bool = false
    @State private var isShowingFavouritesOnly: Bool = false
    @State private var isShowingAlert: Bool = false
    @State private var isShowingNewTransactionScreen: Bool = false
    @StateObject private var accountsList = AccountsList()
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    VStack(spacing: 8) {
                        Text("Solde total :")
                            .padding(.top)
                        Text("\(String(format: "%.2f", accountsList.accounts.map{ $0.amount}.reduce(0, +))) €")
                            .font(.system(size: 32, weight: .bold))
                    }
                    HStack(spacing: 16) {
                        AccentButton(title: "+ transaction", color: Color.violet) {
                            if accountsList.accounts.isEmpty {
                                isShowingAlert = true
                            } else {
                                isShowingNewTransactionScreen = true
                            }
                        }
                        AccentButton(title: "+ account", color: .myOrange) {
                            isPresentingNewAccountScreen = true
                        }
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Mes Comptes")
                                .font(.title2)
                                .bold()
                            Spacer()
                            Button {
                                withAnimation {
                                    isShowingFavouritesOnly.toggle()
                                }
                            } label: {
                                Image(systemName: isShowingFavouritesOnly ? "star.fill" : "star")
                                    .foregroundColor(isShowingFavouritesOnly ? .yellow : Color(white: 0.4))
                                    .padding(.trailing)
                            }
                        }
                        if accountsList.accounts.count > 0 {
                            VStack(spacing: 16) {
                                ForEach(accountsList.accounts) { account in
                                    if !isShowingFavouritesOnly || account.isFavourite {
                                        NavigationLink {
                                           AccountDetailView(account: account)
                                                .environmentObject(accountsList)
                                        } label: {
                                            AccountCell(account: account)
                                        }
                                    }
                                }
                            }
                        }else {
                            Text("Ajoutez un compte")
                                .padding(32)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(24)
            }
            .background(Color.grey)
            .sheet(isPresented: $isPresentingNewAccountScreen) {
                AccountCreationView{ newAccount in
                    accountsList.accounts.append(newAccount)
                }
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("Hop !"),
                    message: Text("Tu dois d'abord créer un compte avant d'y associer des transactions..."),
                    primaryButton: .default(Text("Créer un compte"), action: {
                        isPresentingNewAccountScreen = true
                    }),
                    secondaryButton: .default(Text("Annuler"))
                )
            }
            .sheet(isPresented: $isShowingNewTransactionScreen) {
                NewTransactionView()
                    .environmentObject(accountsList)
            }
        }
        .accentColor(.black)
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                AccountsList.save(accounts: accountsList.accounts) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
            }
        }
        .onAppear {
            AccountsList.load { result in
                switch result {
                case.failure(let error):
                    fatalError(error.localizedDescription)
                case.success(let accounts):
                    accountsList.accounts = accounts
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .padding()
            .background(Color.grey)
            .previewLayout(.sizeThatFits)
    }
}
