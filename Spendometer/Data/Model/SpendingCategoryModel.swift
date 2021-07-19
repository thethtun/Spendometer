//
//  SpendingCategoryModel.swift
//  Spendometer
//
//  Created by Thet Htun on 7/19/21.
//

import Foundation

protocol SpendingCategoryModel {
    func saveSpendingCategory(data : SpendingCategory, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func deleteSpendingCategory(id : String, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func updateSpendingCategory(data : SpendingCategory, success: @escaping () -> Void, fail: @escaping (String) -> Void)
    func getSpendingCategory(success: @escaping ([SpendingCategory]) -> Void, fail: @escaping (String) -> Void)
    func getSpendingCategoryByID(name : String, success: @escaping ([SpendingCategory]) -> Void, fail: @escaping (String) -> Void)
}

class SpendingCategoryModelImpl : BaseModel, SpendingCategoryModel {
    
    static let shared : SpendingCategoryModel = SpendingCategoryModelImpl()
    
    private override init() { }
    
    let spendingCategoryRepository : SpendingCategoryRepository = SpendingCategoryRepositoryImpl.shared
    
    func saveSpendingCategory(data: SpendingCategory, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        spendingCategoryRepository.saveSpendingCategory(data: data, success: success, fail: fail)
    }
    
    func deleteSpendingCategory(id: String, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        spendingCategoryRepository.deleteSpendingCategory(id: id, success: success, fail: fail)
    }
    
    func updateSpendingCategory(data: SpendingCategory, success: @escaping () -> Void, fail: @escaping (String) -> Void) {
        spendingCategoryRepository.updateSpendingCategory(data: data, success: success, fail: fail)
    }
    
    func getSpendingCategory(success: @escaping ([SpendingCategory]) -> Void, fail: @escaping (String) -> Void) {
        spendingCategoryRepository.getSpendingCategory(success: success, fail: fail)
    }
    
    func getSpendingCategoryByID(name : String, success: @escaping ([SpendingCategory]) -> Void, fail: @escaping (String) -> Void) {
        spendingCategoryRepository.getSpendingCategoryByID(name: name, success: success, fail: fail)
    }
    
}
