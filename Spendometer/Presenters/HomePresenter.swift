//
//  HomePresenter.swift
//  Spendometer
//
//  Created by Thet Htun on 12/14/20.
//

import Foundation


protocol HomeView : BaseView {
    func updateSelectedDateTime(data : String)
    func onSaveSuccess()
}

protocol HomePresenter {
    var mView : HomeView? { get set }
    
    func saveSpending(amount : Double, notes: String)
    func dateTimeSelected(date: Date)
    func onCategorySelected(data: SpendingCategory)
}

class HomePresenterImpl : BasePresenterImpl, HomePresenter {
    
    var mView : HomeView?
    
    var spendingRecordModel : SpendingRecordModel = SpendingRecordModelImpl.shared
    
    private var selectedDateTime : Date = Date()
    private var selectedCategory : SpendingCategory = .defaultCategory
    
    func onCategorySelected(data: SpendingCategory) {
        selectedCategory = data
    }
    
    func saveSpending(amount : Double, notes: String) {
        
        let data = SpendingRecord(dateTime: selectedDateTime, category: selectedCategory, createdAt: Date(), amount: amount, notes: notes)
        
        spendingRecordModel.saveSpendingRecord(data: data, success: {
            self.mView?.onSaveSuccess()
        }, fail: { err in
            self.mView?.onError(error: err)
        })
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
