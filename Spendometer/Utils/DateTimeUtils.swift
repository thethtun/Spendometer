//
//  DateTimeUtils.swift
//  Spendometer
//
//  Created by Thet Htun on 12/15/20.
//

import Foundation

public class DateTimeUtils {
    
    public static let DEFAULT_DATE_TIME_FORMAT = "MMM dd, hh:mm"
    
    
    public static func changeDateFormat(date: String, baseFormat: String = "dd-MM-yyyy hh:mm:ss") -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = baseFormat
        guard let resultDate = dateFormatter.date(from: date) else {
            return "invalid date"
        }
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return  dateFormatter.string(from: resultDate)
    }
    
    public static func changeTimeFormat(updateAtDate: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let updateDate = dateFormatter.date(from: updateAtDate)
        dateFormatter.dateFormat = "HH:mm"
        if let date = updateDate {
            return  dateFormatter.string(from: date)
        }
        return  dateFormatter.string(from: updateDate ?? Date())
    }
    
    public static func getTodayDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DEFAULT_DATE_TIME_FORMAT
        return formatter.string(from: date)
    }
    
    public static func convertToString(date: Date, format : String = DEFAULT_DATE_TIME_FORMAT) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    public static func compareTwoDates(date1: Date, date2: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let firstDate = formatter.string(from: date1)
        let secondDate = formatter.string(from: date2)
        
        return firstDate.compare(secondDate) == .orderedSame
    }
    
    public static func getDateByFormat(date: String,format: String = DEFAULT_DATE_TIME_FORMAT) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let temp = dateFormatter.date(from: date)
        if let data = temp{
            return dateFormatter.string(from: data)
        }
        return dateFormatter.string(from: temp ?? Date())
    }
}
