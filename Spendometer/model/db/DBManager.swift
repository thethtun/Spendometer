//
//  DBManager.swift
//  Spendometer
//
//  Created by Thet Htun on 12/14/20.
//

import Foundation

protocol DBManager {
    func saveSpendingRecord(data : SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func deleteSpendingRecord(id : String, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func updateSpendingRecord(data : SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func getSpendingRecords(success: @escaping ([SpendingRecord]) -> Void, fail: @escaping (String) -> Void)
    func getSpendingRecordByID(id : String,success: @escaping (SpendingRecord?) -> Void, fail: @escaping (String) -> Void)
    
    func saveSpendingCategory(data : SpendingCategory, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func deleteSpendingCategory(id : String, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func updateSpendingCategory(data : SpendingCategory, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func getSpendingCategory(success: @escaping ([SpendingCategory]) -> Void, fail: @escaping (String) -> Void)
    func getSpendingCategoryByID(name : String, success: @escaping ([SpendingCategory]) -> Void, fail: @escaping (String) -> Void)
    
}

class DBManagerImpl : DBManager {
    
    //MARK: - SpendingCategory
    func saveSpendingCategory(data: SpendingCategory, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        TempDatabase.categoryList.append(data)
        success()
    }
    
    func deleteSpendingCategory(id: String, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        TempDatabase.categoryList = TempDatabase.categoryList.filter{$0.id != id}
        success()
    }
    
    func updateSpendingCategory(data: SpendingCategory, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        TempDatabase.categoryList = TempDatabase.categoryList.map{
            $0.id == data.id ? data : $0
        }
        success()
    }
    
    func getSpendingCategory(success: @escaping ([SpendingCategory]) -> Void, fail: @escaping (String) -> Void) {
        success(TempDatabase.categoryList)
    }
    
    func getSpendingCategoryByID(name : String, success: @escaping ([SpendingCategory]) -> Void, fail: @escaping (String) -> Void) {
        let result = TempDatabase.categoryList.filter{$0.name.contains(name)}
        result.isEmpty ? fail("No data found with name \(name)") : success(result)
    }
    
    
    
    //MARK: - SpendingRecord
    func saveSpendingRecord(data: SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        TempDatabase.spendingRecordList.append(data)
        success()
    }
    
    func deleteSpendingRecord(id: String, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        TempDatabase.spendingRecordList = TempDatabase.spendingRecordList.filter{$0.id != id}
        success()
    }
    
    func updateSpendingRecord(data: SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        TempDatabase.spendingRecordList = TempDatabase.spendingRecordList.map{
            $0.id == data.id ? data : $0
        }
        success()
    }
    
    func getSpendingRecords(success: @escaping ([SpendingRecord]) -> Void, fail: @escaping (String) -> Void) {
        success(TempDatabase.spendingRecordList)
    }
    
    func getSpendingRecordByID(id: String, success: @escaping (SpendingRecord?) -> Void, fail: @escaping (String) -> Void) {
        success(TempDatabase.spendingRecordList.filter{$0.id == id}.first)
    }
    
}

class TempDatabase {
    private init() { }
    static let instance = TempDatabase()
    
    static var spendingRecordList = [SpendingRecord]()
    static var categoryList = dummyCategories
}
