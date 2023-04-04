//
//  Store.swift
//  Coffee Records
//
//  Created by Jason Koehn on 3/27/23.
//

import Foundation
import FirebaseFirestore

class Store: ObservableObject {
    @Published var roasts: [Roast] = []
    @Published var payments: [Payment] = []
    
    private var roastsDatabase = Firestore.firestore().collection("Roasts")
    private var paymentsDatabase = Firestore.firestore().collection("Payments")
    
    // MARK: Roasts Functions
    func addRoast(date: Date, origin: String, customer: String, pounds: String, paid: Bool) {
        roastsDatabase.addDocument(data: [
            "date": date,
            "origin" : origin,
            "customer": customer,
            "pounds": pounds,
            "paid": paid
        ])
    }
    func fetchRoasts() {
        roastsDatabase.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {return}
            self.roasts = documents.compactMap { queryDocumentSnapshot -> Roast? in
                return try? queryDocumentSnapshot.data(as: Roast.self)
            }
            self.roasts.sort {
                $0.date! < $1.date!
            }
            print(self.roasts)
        }
    }
    func updateRoasts(id: String, date: Date, origin: String, customer: String, pounds: String, paid: Bool) {
        roastsDatabase.document(id).updateData([
            "date": date,
            "origin" : origin,
            "customer": customer,
            "pounds": pounds,
            "paid": paid
        ]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func deleteRoast(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let roast = roasts[index]
            roastsDatabase.document(roast.id ?? "").delete { error in
                if let error = error {
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: Payments Functions
    func addPayment(date: Date, customer: String, amount: Double) {
        paymentsDatabase.addDocument(data: [
            "date": date,
            "customer": customer,
            "amount": amount
        ])
    }
    func fetchPayments() {
        paymentsDatabase.addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {return}
            self.payments = documents.compactMap { queryDocumentSnapshot -> Payment? in
                return try? queryDocumentSnapshot.data(as: Payment.self)
            }
            self.payments.sort {
                $0.date! < $1.date!
            }
        }
    }
    func updatePayments(id: String, date: Date, customer: String, amount: Double) {
        paymentsDatabase.document(id).updateData([
            "date": date,
            "customer": customer,
            "amount": amount
        ]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func deletePayment(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let payment = payments[index]
            paymentsDatabase.document(payment.id ?? "").delete { error in
                if let error = error {
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
}
