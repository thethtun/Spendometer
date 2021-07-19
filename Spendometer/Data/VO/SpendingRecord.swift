//
//  SpendingRecord.swift
//  Spendometer
//
//  Created by Thet Htun on 12/14/20.
//

import Foundation

struct SpendingRecord {
    var id : String = UUID().uuidString
    let dateTime : Date
    let category : SpendingCategory
    let createdAt : Date
    let amount : Double
    let notes : String
}
