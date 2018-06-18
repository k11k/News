//
//  Date+TimeAgo.swift
//  NewsApp
//
//  Created by jsmirnova on 18.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import Foundation

extension Date {
    
    func timeAgo() -> String {
        let unitFlags: NSCalendar.Unit = [.minute, .hour, .day, .month, .year]
        let components = (Calendar.current as NSCalendar).components(unitFlags,
                                                                     from: self,
                                                                     to: Date(),
                                                                     options: [])
        
        if let year = components.year, year > 0 {
            return "\(year) " + "г"
        }
        if let month = components.month, month > 0 {
            return "\(month) " + "м"
        }
        if let day = components.day, day > 0 {
            return "\(day) " + "д"
        }
        if let hour = components.hour, hour > 0 {
            return "\(hour) " + "ч"
        }
        if let minute = components.minute, minute > 0 {
            return "\(minute) " + "мин"
        }
        return "1 " + "мин"
    }
    
}
