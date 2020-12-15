//
//  DoubleExt.swift
//  Spendometer
//
//  Created by Thet Htun on 12/16/20.
//

import Foundation

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
