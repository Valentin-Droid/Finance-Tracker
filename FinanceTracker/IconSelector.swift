//
//  IconSelector.swift
//  FinanceTracker
//
//  Created by Valentin Drelon on 16/01/2023.
//

import SwiftUI

struct IconSelector: View {
    
    @Binding var selectedIcon: String
    
    private let icons = [
        "icon_001",
        "icon_002",
        "icon_003",
        "icon_004",
        "icon_005",
        "icon_006",
        "icon_007"
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(icons, id: \.self) { iconName in
                    Button {
                        selectedIcon = iconName
                    } label: {
                        Circle()
                            .frame(width: 65, height: 65)
                            .foregroundColor(iconName == selectedIcon ? .black : .white)
                            .overlay(
                                Image(iconName)
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(iconName == selectedIcon ? .white : .black)
                                    .frame(width: 35, height: 35)
                            )
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct IconSelector_Previews: PreviewProvider {
    
    @State static var previewSelectedIcon = "icon_001"
    
    static var previews: some View {
        IconSelector(selectedIcon: $previewSelectedIcon)
                    .padding(.vertical)
                    .previewLayout(.sizeThatFits)
                    .background(Color.grey)
    }
}
