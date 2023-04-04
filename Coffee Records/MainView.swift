//
//  MainView.swift
//  Coffee Records
//
//  Created by Jason Koehn on 3/27/23.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var store: Store
    @State private var showAddRoastView: Bool = false
    @State private var showAddPaymentView: Bool = false
    var body: some View {
        TabView {
            RoastRecordsView()
                .tabItem {
                    Label("Roasts", systemImage: "flame.fill")
                }
            PaymentRecordsView()
                .tabItem {
                    Label("Payments", systemImage: "dollarsign")
                }
        }
            .navigationTitle("Coffee Records")
            .onAppear {
                store.fetchRoasts()
                store.fetchPayments()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Settings View
                    }) {
                        Image(systemName: "gear")
                            .font(.system(size: 19))
                    }
                }
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
