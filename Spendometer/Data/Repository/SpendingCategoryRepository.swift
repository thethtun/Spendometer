//
//  SpendingCategoryRepository.swift
//  Spendometer
//
//  Created by Thet Htun on 7/19/21.
//

import Foundation

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
        db.categoryList.append(data)
        success()
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
        success(db.categoryList)
    }
    
    func getSpendingCategoryByID(name : String, success: @escaping ([SpendingCategory]) -> Void, fail: @escaping (String) -> Void) {
        let result = db.categoryList.filter{$0.name.lowercased().contains(name.lowercased())}
        success(result)
//        result.isEmpty ? fail("No data found with name \(name)") : success(result)
    }
    
    
    
}
