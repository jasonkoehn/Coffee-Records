//
//  Coffee_RecordsApp.swift
//  Coffee Records
//
//  Created by Jason Koehn on 3/27/23.
//

import SwiftUI
import Firebase

@main
struct Coffee_RecordsApp: App {
    @StateObject var store = Store()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(store)
        }
    }
}
