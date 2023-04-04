//
//  AddRoastView.swift
//  Coffee Records
//
//  Created by Jason Koehn on 3/27/23.
//

import SwiftUI

struct AddRoastView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: Store
    @State var date: Date = Date()
    @State var origin: String = "Bali"
    @State var originText: String = ""
    @State var customer: String = "Home/Todds"
    @State var customerText: String = ""
    @State var pound: String = "1"
    @State var poundValue: String = ""
    var body: some View {
        List {
            DatePicker("Date:", selection: $date, displayedComponents: .date)
                .font(.system(size: 20))
            Picker("Origin:", selection: $origin) {
                ForEach(origins, id: \.self) { origin in
                    Text(origin).tag(origin)
                }
                Text("Other").tag("Other")
            }
            .pickerStyle(.menu)
            if origin == "Other" {
                TextField("", text: $originText)
                    .textFieldStyle(.roundedBorder)
            }
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
            Picker("Pounds:", selection: $pound) {
                Text("1").tag("1")
                Text("2").tag("2")
                Text("Other").tag("Other")
            }
            .pickerStyle(.menu)
            if pound == "Other" {
                TextField("", text: $poundValue)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .navigationTitle("Add A Roast")
        .toolbar {
            Button(action: {
                store.addRoast(date: date, origin: origin, customer: customer, pounds: pound, paid: false)
                dismiss()
            }) {
                Text("Save")
                    .font(.system(size: 19))
            }
        }
    }
}

struct AddRoastView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoastView()
    }
}
