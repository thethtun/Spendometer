//
//  SpendingCategoryRepository.swift
//  Spendometer
//
//  Created by Thet Htun on 7/19/21.
//

import CoreData

protocol SpendingCategoryRepository {
    func saveSpendingCategory(data : SpendingCategory, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func deleteSpendingCategory(id : String, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func updateSpendingCategory(data : SpendingCategory, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func getSpendingCategory(success: @escaping ([SpendingCategory]) -> Void, fail: @escaping (String) -> Void)
    func getSpendingCategoryByID(name : String, success: @escaping ([SpendingCategory]) -> Void, fail: @escaping (String) -> Void)
}

class SpendingCategoryRepositoryImpl: BaseRepository, SpendingCategoryRepository {
    
    static let shared = SpendingCategoryRepositoryImpl()
    
    private override init() { }
    
    func saveSpendingCategory(data: SpendingCategory, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        let entity = SpendingCategoryEntity(context: coreDataDB.persistentContainer.viewContext)
        entity.id = data.id
        entity.name = data.name
        
        do {
            try coreDataDB.persistentContainer.viewContext.save()
            success()
        } catch {
            print(handleCoreDataError(error))
            fail(DBError.failedToSave.rawValue)
        }
    }
    
    func deleteSpendingCategory(id: String, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        db.categoryList = db.categoryList.filter{$0.id != id}
        success()
    }
    
    func updateSpendingCategory(data: SpendingCategory, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        db.categoryList = db.categoryList.map{
            $0.id == data.id ? data : $0
        }
        success()
    }
    
    func getSpendingCategory(success: @escaping ([SpendingCategory]) -> Void, fail: @escaping (String) -> Void) {
        let fetchRequest : NSFetchRequest<SpendingCategoryEntity> = SpendingCategoryEntity.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]
        
        do {
            let data = try coreDataDB.persistentContainer.viewContext.fetch(fetchRequest)
            success(data.isEmpty ? addPredefinedSpendingCategories() : data.map { SpendingCategoryEntity.toSpendingCategory(data: $0) })
        } catch {
            let error = error as NSError
            fail(error.description)
        }
        
    }
    
    func getSpendingCategoryByID(name : String, success: @escaping ([SpendingCategory]) -> Void, fail: @escaping (String) -> Void) {
        let fetchRequest : NSFetchRequest<SpendingCategoryEntity> = SpendingCategoryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K CONTAINS[cd] %@", "name", name)
        
        do {
            let data = try coreDataDB.persistentContainer.viewContext.fetch(fetchRequest)
            success(data.map { SpendingCategoryEntity.toSpendingCategory(data: $0) })
        } catch {
            let error = error as NSError
            fail(error.description)
        }
    }
    
    
    private func addPredefinedSpendingCategories() -> [SpendingCategory] {
        let data = [
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
            SpendingCategory(name: "Business"),
        ]
        
        data.forEach { item in
            saveSpendingCategory(data: item, success: {}, fail: {_ in})
        }
        
        return data
    }
    
    
}
