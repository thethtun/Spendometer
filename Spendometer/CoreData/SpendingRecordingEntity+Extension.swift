//
//  SpendingRecordingEntity+Extension.swift
//  Spendometer
//
//  Created by Thet Htun on 7/20/21.
//

import Foundation

extension SpendingRecordEntity {
    static func toSpendingRecord(data : SpendingRecordEntity) -> SpendingRecord {
        return SpendingRecord(
            id: data.id ?? "" ,
            dateTime: data.dateTime ?? Date(),
            category: SpendingCategoryEntity.toSpendingCategory(data: data.category!),
            createdAt: data.createdAt ?? Date(),
            amount: data.amount,
            notes: data.notes ?? "")
    }
}
