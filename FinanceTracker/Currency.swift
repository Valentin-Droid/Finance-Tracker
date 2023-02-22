//
//  Currency.swift
//  FinanceTracker
//
//  Created by Valentin Drelon on 13/01/2023.
//

import Foundation

enum Currency: String, CaseIterable, Codable {
    case dollar = "$"
    case euro = "€"
    case ruble = "₽"
    case sterling = "£"
    case yen = "¥"
    
    var iconName: String {
        switch self {
        case .dollar:
            return "dollarsign.circle"
        case .euro:
            return "eurosign.circle"
        case .ruble:
            return "rublesign.circle"
        case .sterling:
            return "sterlingsign.circle"
        case .yen:
            return "yensign.circle"
        }
    }
    
    var filledIconName: String {
        return "\(iconName).fill"
    }
}
