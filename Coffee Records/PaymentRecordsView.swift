//
//  PaymentRecordsView.swift
//  Coffee Records
//
//  Created by Jason Koehn on 3/27/23.
//

import SwiftUI

struct PaymentRecordsView: View {
    @EnvironmentObject var store: Store
    @State private var showAddPaymentView: Bool = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(store.payments, id: \.id) { payment in
                    HStack {
                        HStack {
                            Text(payment.date!.formatted(.dateTime.day().month()))
                                .font(.system(size: 19))
                                .foregroundColor(.blue)
                            Spacer()
                        }
                        .frame(width: 80)
                        Text(payment.customer ?? "")
                            .font(.system(size: 19))
                        Spacer()
                        Text(payment.amount!.formatted(.currency(code: "USD")))
                            .font(.system(size: 19))
                            .foregroundColor(.green)
                    }
                }
                .onDelete(perform: store.deletePayment(at:))
            }
            .navigationTitle("Payments")
            .listStyle(.inset)
            .refreshable {
                store.fetchPayments()
            }
            .toolbar {
                Button(action: {
                    showAddPaymentView.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 19))
                }
            }
            .sheet(isPresented: $showAddPaymentView) {
                NavigationStack {
                    AddPaymentView()
                }
            }
        }
    }
}

struct PaymentRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentRecordsView()
    }
}
