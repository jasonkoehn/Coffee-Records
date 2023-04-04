//
//  AddPaymentView.swift
//  Coffee Records
//
//  Created by Jason Koehn on 3/27/23.
//

import SwiftUI

struct AddPaymentView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: Store
    @State var date: Date = Date()
    @State var customer: String = "Andres Koehn"
    @State var customerText: String = ""
    @State var amount: Double = 14
    var body: some View {
        List {
            DatePicker("Date:", selection: $date, displayedComponents: .date)
                .font(.system(size: 20))
            Picker("Customer:", selection: $customer) {
                ForEach(customers, id: \.self) { customer in
                    Text(customer).tag(customer)
                    
                }
                Text("Other").tag("Other")
            }
            .pickerStyle(.menu)
            if customer == "Other" {
                TextField("", text: $customerText)
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                Text("Amount:")
                TextField("Amount", value: $amount, formatter: Formatter.inNumberFormat)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numbersAndPunctuation)
            }
        }
        .navigationTitle("Add A Payment")
        .toolbar {
            Button(action: {
                store.addPayment(date: date, customer: customer, amount: amount)
                dismiss()
            }) {
                Text("Save")
                    .font(.system(size: 19))
            }
        }
    }
}

struct AddPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        AddPaymentView()
    }
}


extension Formatter {
    static let inNumberFormat: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
}
