//
//  Structs.swift
//  Coffee Records
//
//  Created by Jason Koehn on 3/27/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Roast: Codable {
    @DocumentID var id: String?
    var date: Date?
    var origin: String?
    var customer: String?
    var pounds: String?
    var paid: Bool?
}

struct Payment: Codable {
    @DocumentID var id: String?
    var date: Date?
    var customer: String?
    var amount: Double?
}


var origins: [String] = ["Bali", "Bolivia", "Brazil", "Colombia", "Costa Rica", "Ethiopia", "Guatemala", "Honduras", "India", "Kenya", "Mexico", "Nicaragua", "Panama", "Papua New Guinea", "Peru", "Red Sea", "Sumatra", "Tanzania"]

var customers: [String] = ["Home/Todds", "Andres Koehn", "Caleb Mininger", "Jaylin Nickel", "Jo Nickel", "Joshua Koehn", "Kirby Toews", "Linda Schmidt", "Michael Jantz", "Murray Wiebe", "Scott Koehn"]
