//
//  FinanceTrackerApp.swift
//  FinanceTracker
//
//  Created by Valentin Drelon on 11/01/2023.
//

import SwiftUI

extension Color {
    static let grey = Color("grey")
    static let myOrange = Color("orange")
    static let violet = Color("purple")
}

@main
struct FinanceTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
