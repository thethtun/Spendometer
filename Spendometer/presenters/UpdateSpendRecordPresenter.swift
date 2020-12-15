//
//  UpdateSpendRecordPresenter.swift
//  Spendometer
//
//  Created by Thet Htun on 12/16/20.
//

import Foundation

protocol UpdateSpendingRecordView : BaseView {
    func updateSelectedDateTime(data : String)
    func onSaveSuccess()
    func onDataNotFound(data : String)
    func onSpendingRecordLoaded(data : SpendingRecord)
}

protocol UpdateSpendingRecordPresenter {
    var mView : UpdateSpendingRecordView? { get set }
    
    func updateRecord(amount: Double, notes: String)
    func getSpendingRecordByID(id : String)
    func dateTimeSelected(date: Date)
    func onCategorySelected(data: SpendingCategory)
}


class UpdateSpendingRecordPresenterImpl : BasePresenterImpl, UpdateSpendingRecordPresenter {
    
    var mView : UpdateSpendingRecordView?
    
    private var selectedDateTime : Date = Date()
    private var selectedCategory : SpendingCategory = .defaultCategory
    private var targetRecord : SpendingRecord?
    
    func onCategorySelected(data: SpendingCategory) {
        selectedCategory = data
    }
    
    func getSpendingRecordByID(id: String) {
        db?.getSpendingRecordByID(id: id, success: { (data) in
            if let data = data {
                self.targetRecord = data
                self.selectedCategory = data.category
                self.selectedDateTime = data.dateTime
                
                self.mView?.onSpendingRecordLoaded(data: data)
            } else {
                self.mView?.onDataNotFound(data: "No data found with id : \(id)")
            }
        }, fail: { (error) in
            self.mView?.onDataNotFound(data: "No data found with id : \(id)")
        })
    }
    
    func updateRecord(amount: Double, notes: String) {
        if let spendingRecord = targetRecord {
            let data = SpendingRecord(
                id : spendingRecord.id,
                dateTime: selectedDateTime,
                category: selectedCategory,
                createdAt: Date(),
                amount: amount,
                notes: notes)
            
            db?.updateSpendingRecord(data: data, success: {
                self.mView?.onSaveSuccess()
            }, fail: { (error) in
                self.mView?.onError(error: error)
            })
        } else {
            self.mView?.onError(error: "No record to update!")
        }
        
    }
    
    func dateTimeSelected(date: Date) {
        self.selectedDateTime = date
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: date)
        
        mView?.updateSelectedDateTime(data: selectedDate)
    }
    
    
}
