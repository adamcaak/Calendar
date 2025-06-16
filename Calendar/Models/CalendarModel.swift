//
//  CalendarModel.swift
//  Calendar
//
//  Created by Łukasz Adamczak on 16/06/2025.
//

import Foundation
import SwiftUI

struct CalendarModel {
    let calendar = Calendar.current
    let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    func getDaysOfMonth(for date: Date) -> [Date?] {
        let interval = calendar.dateInterval(of: .month, for: date)!
        let firstDay = interval.start
        
        let firstWeekday = calendar.component(.weekday, from: firstDay)
        let offsetDays = firstWeekday - 1
        
        let daysInMonth = calendar.range(of: .day, in: .month, for: date)!.count
        
        var days: [Date?] = Array(repeating: nil, count: offsetDays)
        
        for day in 1...daysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDay) {
                days.append(date)
            }
        }
        let remainingDays = 7 - (days.count % 7)
        if remainingDays < 7 {
            days.append(contentsOf: Array(repeating: nil, count: remainingDays))
        }
        return days
    }
    
    func moveMonth(for date: Date, by value: Int) -> Date? {
        return calendar.date(byAdding: .month, value: value, to: date)
    }
    
    func isDateInToday(_ date: Date) -> Bool {
        return calendar.isDateInToday(date)
    }
    
    func isDate(_ date1: Date, inSameDayAs date2: Date) -> Bool {
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func getYear(from date: Date) -> Int {
        return calendar.component(.year, from: date)
    }
    
    func getMonth(from date: Date) -> Int {
        return calendar.component(.month, from: date)
    }
    
    func createDate(year: Int, month: Int) -> Date? {
        return calendar.date(from: DateComponents(year: year, month: month, day: 1))
    }
}
