//
//  SpendingCategory.swift
//  Spendometer
//
//  Created by Thet Htun on 12/14/20.
//

import Foundation

struct SpendingCategory {
    let id : String = UUID().uuidString
    let name : String
    
    static let defaultCategory = SpendingCategory(name: "unknown")
}


let dummyCategories = [
    SpendingCategory(name: "Food"),
    SpendingCategory(name: "Clothes"),
    SpendingCategory(name: "Bills"),
    SpendingCategory(name: "Education"),
    SpendingCategory(name: "Gaming"),
    SpendingCategory(name: "Loan Interest"),
    SpendingCategory(name: "Medical"),
    SpendingCategory(name: "Social"),
    SpendingCategory(name: "Love"),
    SpendingCategory(name: "Entertainment"),
    SpendingCategory(name: "Funeral"),
    SpendingCategory(name: "Business"),
    SpendingCategory(name: "Banana"),
    SpendingCategory(name: "K-POP"),
]
