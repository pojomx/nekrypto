//
//  DateExtensions.swift
//  Nekrypto
//
//  Created by Alan Milke on 23/05/25.
//
import Foundation

extension Date {

    public static func calculateBroadcastDate(_ stringDate: String) -> String? {
        let dateFormatString = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let finalFormatString = "yy-MM-dd, HH:mm:ss"
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatString
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = formatter.date(from: stringDate) else { return nil }
        
        formatter.dateFormat = finalFormatString
        formatter.timeZone = TimeZone.current

        return formatter.string(from: date)
    }
    
}
