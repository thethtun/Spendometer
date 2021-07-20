//
//  SpendingRecord.swift
//  Spendometer
//
//  Created by Thet Htun on 12/14/20.
//

import Foundation
import CoreData

struct SpendingRecord {
 
    var id : String = UUID().uuidString
    let dateTime : Date
    let category : SpendingCategory
    let createdAt : Date
    let amount : Double
    let notes : String
    
    init(id: String = UUID().uuidString, dateTime: Date, category: SpendingCategory, createdAt: Date, amount: Double, notes: String) {
        self.id = id
        self.dateTime = dateTime
        self.category = category
        self.createdAt = createdAt
        self.amount = amount
        self.notes = notes
    }
    
    func toSpendingRecordEntity(entity : SpendingRecordEntity, context: NSManagedObjectContext) -> SpendingRecordEntity {
        entity.id = self.id
        entity.dateTime = self.dateTime
        entity.category = SpendingCategoryEntity.fetchById(context: context, id : self.category.id)
        entity.createdAt = self.createdAt
        entity.amount = self.amount
        entity.notes = self.notes
        return entity
    }
    
}
