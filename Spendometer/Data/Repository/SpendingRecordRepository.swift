//
//  SpendingRecordRepository.swift
//  Spendometer
//
//  Created by Thet Htun on 7/19/21.
//

import Foundation

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
        success(db.spendingRecordList.filter{DateTimeUtils.compareTwoDates(date1: $0.dateTime, date2: date)})
    }
    
    func saveSpendingRecord(data: SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        db.spendingRecordList.append(data)
        success()
    }
    
    func deleteSpendingRecord(id: String, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        db.spendingRecordList = db.spendingRecordList.filter{$0.id != id}
        success()
    }
    
    func updateSpendingRecord(data: SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        db.spendingRecordList = db.spendingRecordList.map{
            $0.id == data.id ? data : $0
        }
        success()
    }
    
    func getSpendingRecords(success: @escaping ([SpendingRecord]) -> Void, fail: @escaping (String) -> Void) {
        success(db.spendingRecordList)
    }
    
    func getSpendingRecordByID(id: String, success: @escaping (SpendingRecord?) -> Void, fail: @escaping (String) -> Void) {
        success(db.spendingRecordList.filter{$0.id == id}.first)
    }
}
