//
//  SpendingRecordRepository.swift
//  Spendometer
//
//  Created by Thet Htun on 7/19/21.
//

import Foundation
import CoreData

protocol SpendingRecordRepository {
    func saveSpendingRecord(data : SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func deleteSpendingRecord(id : String, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func updateSpendingRecord(data : SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func getSpendingRecords(success: @escaping ([SpendingRecord]) -> Void, fail: @escaping (String) -> Void)
    func getSpendingRecordByID(id : String,success: @escaping (SpendingRecord?) -> Void, fail: @escaping (String) -> Void)
    func getSpendingRecordByDate(date : Date,success: @escaping ([SpendingRecord]) -> Void, fail: @escaping (String) -> Void)
}

class SpendingRecordRepositoryImpl: BaseRepository, SpendingRecordRepository {
    
    static let shared = SpendingRecordRepositoryImpl()
    
    private override init() { }
    
    func getSpendingRecordByDate(date : Date, success: @escaping ([SpendingRecord]) -> Void, fail: @escaping (String) -> Void) {
        let fetchRequest : NSFetchRequest<SpendingRecordEntity> = SpendingRecordEntity.fetchRequest()

        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local

        let fromDate = calendar.startOfDay(for: date)

        let toDate = calendar.date(byAdding: .day, value: 1, to: fromDate)!
        fetchRequest.predicate = NSPredicate(format: "dateTime >= %@ AND dateTime < %@", fromDate as NSDate, toDate as NSDate)

        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "createdAt", ascending: false) // last row first
        ]
        
        do {
            let data = try coreDataDB.persistentContainer.viewContext.fetch(fetchRequest)
            success(data.map { SpendingRecordEntity.toSpendingRecord(data: $0) } )
        } catch {
            print(handleCoreDataError(error))
            fail(error.localizedDescription)
        }
        
    }
    
    func saveSpendingRecord(data: SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        let _ = data.toSpendingRecordEntity(
            entity: SpendingRecordEntity(context: coreDataDB.context),
            context: coreDataDB.persistentContainer.viewContext)
        
        do {
            try coreDataDB.context.save()
            success()
        } catch {
            print(handleCoreDataError(error))
            fail(error.localizedDescription)
        }
    }
    
    func deleteSpendingRecord(id: String, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        let fetchRequest : NSFetchRequest<SpendingRecordEntity> = SpendingRecordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "id", id)
        
        do {
            let data = try coreDataDB.context.fetch(fetchRequest)
            data.forEach{ coreDataDB.context.delete($0) }
            
            try coreDataDB.context.save()
            success()
        } catch {
            print(handleCoreDataError(error))
            fail(error.localizedDescription)
        }
    }
    
    func updateSpendingRecord(data: SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        let fetchRequest : NSFetchRequest<SpendingRecordEntity> = SpendingRecordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "id", data.id)
        
        do {
            let result = try coreDataDB.context.fetch(fetchRequest)
            if let entity = result.first {
                let _ = data.toSpendingRecordEntity(entity: entity, context: coreDataDB.context)
                
                try coreDataDB.context.save()
                success()
            } else {
                fail(DBError.failedToUpdateEmptyItem.rawValue)
            }
            
        } catch {
            print(handleCoreDataError(error))
            fail(error.localizedDescription)
        }
    }
    
    func getSpendingRecords(success: @escaping ([SpendingRecord]) -> Void, fail: @escaping (String) -> Void) {
        let fetchRequest : NSFetchRequest<SpendingRecordEntity> = SpendingRecordEntity.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "createdAt", ascending: false) // last row first
        ]
        
        do {
            let data = try coreDataDB.persistentContainer.viewContext.fetch(fetchRequest)
            success(data.map { SpendingRecordEntity.toSpendingRecord(data: $0) } )
        } catch {
            print(handleCoreDataError(error))
            fail(error.localizedDescription)
        }
    }
    
    func getSpendingRecordByID(id: String, success: @escaping (SpendingRecord?) -> Void, fail: @escaping (String) -> Void) {
        let fetchRequest : NSFetchRequest<SpendingRecordEntity> = SpendingRecordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "id", id)
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "createdAt", ascending: false) // last row first
        ]
        
        do {
            let data = try coreDataDB.persistentContainer.viewContext.fetch(fetchRequest)
            success(data.map { SpendingRecordEntity.toSpendingRecord(data: $0) }.first )
        } catch {
            print(handleCoreDataError(error))
            fail(error.localizedDescription)
        }
        
    }
}
