//
//  DBError.swift
//  Spendometer
//
//  Created by Thet Htun on 7/20/21.
//

import Foundation

enum DBError : String {
    case failedToSave = "Failed to save data"
    case failedToUpdate = "Failed to update data"
    case failedToDelete = "Failed to delete data"
    case failedToUpdateEmptyItem = "Can't find item to update"
    case failedToFetch = "Unable to get data from database"
}
