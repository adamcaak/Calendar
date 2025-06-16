//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by Łukasz Adamczak on 16/06/2025.
//

import SwiftUI
import Foundation

class CalendarViewModel: ObservableObject {
    @Published var selectedDate: Date
    @Published var currentMonth: Date
    @Published var showYearPicker: Bool
    
    private let calendarModel: CalendarModel
    
    let primaryColor = Color(red: 0.2, green: 0.5, blue: 0.9)
    let secondaryColor = Color(red: 0.95, green: 0.95, blue: 0.97)
    let textColor = Color(red: 0.2, green: 0.2, blue: 0.2)
    let accentGradient = LinearGradient(
        colors: [Color(red: 0.2, green: 0.5, blue: 0.9), Color(red: 0.3, green: 0.6, blue: 1.0)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
        )
    
    init(calendarModel: CalendarModel = CalendarModel()) {
        self.calendarModel = calendarModel
        self.selectedDate = Date()
        self.currentMonth = Date()
        self.showYearPicker = false
    }
    
    var daysInMonth: [Date?] {
        calendarModel.getDaysOfMonth(for: currentMonth)
    }
    
    var dayOfWeek: [String] {
        calendarModel.daysOfWeek
    }
    
    func moveMonth(by value: Int) {
        if let newDate = calendarModel.moveMonth(for: currentMonth, by: value) {
            withAnimation(.spring()) {
                currentMonth = newDate
            }
        }
    }
    
    func selectDate(_ date: Date) {
        withAnimation(.spring()) {
            selectedDate = date
        }
    }
    
    func isDateSelected(_ date: Date) -> Bool {
        calendarModel.isDate(date, inSameDayAs: selectedDate)
    }
    
    func isDateToday(_ date: Date) -> Bool {
        calendarModel.isDateInToday(date)
    }
    
    func selectYear(_ year: Int) {
        if let newDate = calendarModel.createDate(
            year: year,
            month: calendarModel.getMonth(from: currentMonth)
        ) {
            currentMonth = newDate
        }
        showYearPicker = false
    }
    
    var currentYear: Int {
        calendarModel.getYear(from: currentMonth)
    }
    
    var yearRange: ClosedRange<Int> {
        (currentYear - 10)...(currentYear + 10)
    }
}
