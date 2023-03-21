//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Dhiman on 2023-03-20.
//

import SwiftUI

@main
struct CalculatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
