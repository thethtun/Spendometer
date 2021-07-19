//
//  DBManager.swift
//  Spendometer
//
//  Created by Thet Htun on 12/14/20.
//

import Foundation


class TempDatabase {
    private init() { }
    static let shared = TempDatabase()
    
    var spendingRecordList = [SpendingRecord]()
    var categoryList = dummyCategories
}
