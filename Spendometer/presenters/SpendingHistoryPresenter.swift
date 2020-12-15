//
//  SpendingHistoryPresenter.swift
//  Spendometer
//
//  Created by Thet Htun on 12/15/20.
//

import Foundation



protocol SpendingHistoryView : BaseView {
    func onSpendingHistoryReady(data: [SpendingRecord])
    func onTotalSpendingCalculated(totalSpending: String)
}

protocol SpendingHistoryPresenter {
    var mView : SpendingHistoryView? { get set }
    var spendingHistory : [SpendingRecord] { get set }
    
    func getSpendingListByDate(date : Date)
    func deleteHistoryItemBydID(id : String)
}


class SpendingHistoryPresenterImpl : BasePresenterImpl, SpendingHistoryPresenter {

    var mView : SpendingHistoryView?
    var spendingHistory = [SpendingRecord]() {
        didSet {
            self.mView?.onTotalSpendingCalculated(totalSpending: spendingHistory.reduce(0) { (result, data) -> Double in
                return result + data.amount
            }.withCommas())
        }
    }
    
    func getSpendingListByDate(date : Date) {
        db?.getSpendingRecordByDate(date: date, success: { (data) in
            self.spendingHistory = data
            self.mView?.onSpendingHistoryReady(data: data)
        }, fail: { (error) in
            self.mView?.onError(error: error)
        })
    }
    
    func deleteHistoryItemBydID(id : String) {
        db?.deleteSpendingRecord(id: id, success: {
            self.spendingHistory = self.spendingHistory.filter{$0.id != id}
            self.mView?.onSpendingHistoryReady(data: self.spendingHistory)
        }, fail: { (error) in
            self.mView?.onError(error: error)
        })
    }

}
