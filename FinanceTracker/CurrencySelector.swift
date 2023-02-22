//
//  CurrencySelector.swift
//  FinanceTracker
//
//  Created by Valentin Drelon on 13/01/2023.
//

import SwiftUI

struct CurrencySelector: View {
    
    @Binding var selectedCurrency: Currency
    @State private var isSeletingMode = false
    private let currencies = Currency.allCases
    
    var body: some View {
        ZStack {
            ForEach(currencies.indices) { index in
                Image(systemName: selectedCurrency == currencies[index] ? currencies[index].filledIconName : currencies[index].iconName)
                    .font(.system(size: 32))
                    .offset(x: isSeletingMode ? -CGFloat(index) * 40 : 0)
                    .opacity(selectedCurrency == currencies[index] || isSeletingMode ? 1 : 0)
                    .onTapGesture {
                        if isSeletingMode {
                            selectedCurrency = currencies[index]
                        }
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isSeletingMode.toggle()
                        }
                    }
            }
        }
    }
}

struct CurrencySelector_Previews: PreviewProvider {
    
    @State static var previewSelectedCurrency: Currency = .dollar
    
    static var previews: some View {
        CurrencySelector(selectedCurrency: $previewSelectedCurrency)
    }
}
