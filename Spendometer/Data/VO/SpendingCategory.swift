//
//  SpendingCategory.swift
//  Spendometer
//
//  Created by Thet Htun on 12/14/20.
//

import Foundation
import CoreData

struct SpendingCategory {
    let id : String
    let name : String
    
    init(id: String, name : String) {
        self.id = id
        self.name = name
    }
    
    init(name: String) {
        self.init(id: UUID().uuidString, name: name)
    }
    
    static let defaultCategory = SpendingCategory(name: "unknown")
    
    func toSpendingCategoryEntity(context: NSManagedObjectContext) -> SpendingCategoryEntity {
        let entity = SpendingCategoryEntity(context: context)
        entity.id = self.id
        entity.name = self.name
        return entity
    }
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
