//
//  SpendingRecordModel.swift
//  Spendometer
//
//  Created by Thet Htun on 7/19/21.
//

import Foundation

protocol SpendingRecordModel {
    func saveSpendingRecord(data : SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func deleteSpendingRecord(id : String, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func updateSpendingRecord(data : SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func getSpendingRecords(success: @escaping ([SpendingRecord]) -> Void, fail: @escaping (String) -> Void)
    func getSpendingRecordByID(id : String,success: @escaping (SpendingRecord?) -> Void, fail: @escaping (String) -> Void)
    func getSpendingRecordByDate(date : Date,success: @escaping ([SpendingRecord]) -> Void, fail: @escaping (String) -> Void)
}

class SpendingRecordModelImpl : BaseModel, SpendingRecordModel {
    
    static let shared = SpendingRecordModelImpl()
    
    private override init() { }
    
    let spendingRecordRepository : SpendingRecordRepository = SpendingRecordRepositoryImpl.shared
    
    func getSpendingRecordByDate(date : Date, success: @escaping ([SpendingRecord]) -> Void, fail: @escaping (String) -> Void) {
        spendingRecordRepository.getSpendingRecordByDate(date: date, success: success, fail: fail)
    }
    
    func saveSpendingRecord(data: SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        spendingRecordRepository.saveSpendingRecord(data: data, success: success, fail: fail)
    }
    
    func deleteSpendingRecord(id: String, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        spendingRecordRepository.deleteSpendingRecord(id: id, success: success, fail: fail)
    }
    
    func updateSpendingRecord(data: SpendingRecord, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        spendingRecordRepository.updateSpendingRecord(data: data, success: success, fail: fail)
    }
    
    func getSpendingRecords(success: @escaping ([SpendingRecord]) -> Void, fail: @escaping (String) -> Void) {
        spendingRecordRepository.getSpendingRecords(success: success, fail: fail)
    }
    
    func getSpendingRecordByID(id: String, success: @escaping (SpendingRecord?) -> Void, fail: @escaping (String) -> Void) {
        spendingRecordRepository.getSpendingRecordByID(id: id, success: success, fail: fail)
    }
}
