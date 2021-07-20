//
//  SpendingCategoryEntity+Extension.swift
//  Spendometer
//
//  Created by Thet Htun on 7/20/21.
//

import Foundation
import CoreData

extension SpendingCategoryEntity {
    static func toSpendingCategory(data : SpendingCategoryEntity) -> SpendingCategory {
        return SpendingCategory(id: data.id ?? "", name: data.name ?? "")
    }
    
    static func fetchById(context : NSManagedObjectContext, id : String) -> SpendingCategoryEntity? {
        let fetchRequest : NSFetchRequest<SpendingCategoryEntity> = SpendingCategoryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "id", id)
        
        let data = try? context.fetch(fetchRequest)
        return data?.first
    }
}
