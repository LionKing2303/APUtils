//
//  Date+Extension.swift
//  Time2Time
//
//  Created by Arie Peretz on 24/04/2020.
//  Copyright © 2020 Arie Peretz. All rights reserved.
//

import Foundation

/// Usage:
///
/// someDate.string(for: .birthdate)

extension Date {
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    func convertToLocalTime(fromTimeZone timeZoneAbbreviation: String) -> Date? {
        if let timeZone = TimeZone(abbreviation: timeZoneAbbreviation) {
            let targetOffset = TimeInterval(timeZone.secondsFromGMT(for: self))
            let localOffeset = TimeInterval(TimeZone.autoupdatingCurrent.secondsFromGMT(for: self))

            return self.addingTimeInterval(targetOffset - localOffeset)
        }

        return nil
    }
    
    enum Format: String, CaseIterable {
        case backend = "YYYY-MM-dd'T'HH:mm:ss'Z'"
        case backendMid = "yyyy-MM-dd'T'HH:mmZZZ"
        case backendShort = "YYYY-MM-dd"
        case hour = "HH"
        case minute = "mm"
        case `default` = "YYYY-MM-dd HH:MM"
        case dayShort = "EEE"
        case timeShort = "H:mm"
        case title = "EEEE, H:mm"
        case dateShort = "dd.MM.yyyy"
        case timeMidium = "EEE dd MMM H:mm"
        case timeLong = "EEE dd MMM, YYYY H:mm"
        case time24 = "HH:mm"
        case time12 = "hh:mm a"
        case time24Seconds = "HH:mm:ss"
        case dateAndTime = "dd.MM.yyyy HH:mm:ss"
        case monthYear = "MM/yyyy"
    }
    
    private static var monthYearFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.monthYear.rawValue
        return formatter
    }()
    
    private static var dateAndTimeFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.dateAndTime.rawValue
        return formatter
    }()
    
    private static var time24SecondsFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.time24Seconds.rawValue
        return formatter
    }()
    
    private static var time24Formatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.time24.rawValue
        return formatter
    }()
    
    private static var time12Formatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.time12.rawValue
        return formatter
    }()
    
    private static var backendFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.backend.rawValue
        return formatter
    }()
    
    private static var dateDetailShortFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.timeLong.rawValue
        return formatter
    }()
    
    private static var timeMidiumFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.timeMidium.rawValue
        return formatter
    }()
    
    private static var hourFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.hour.rawValue
        return formatter
    }()
    
    private static var minuteFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.minute.rawValue
        return formatter
    }()
    
    private static var defaultFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.default.rawValue
        return formatter
    }()
    
    private static var dateShortFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.dateShort.rawValue
        return formatter
    }()
    
    private static var titleFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.title.rawValue
        return formatter
    }()
    
    private static var dayShortFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.dayShort.rawValue
        return formatter
    }()
    
    private static var timeShortFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.timeShort.rawValue
        return formatter
    }()
    
    private static var backendShortFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.backendShort.rawValue
        return formatter
    }()
    
    private static var backendMidFormatter: DateFormatter = {
        let formatter = baseFormatter()
        formatter.dateFormat = Format.backendMid.rawValue
        return formatter
    }()
    
    func startOfDay(to format: Format) -> String {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: self) else { return "" }
        return Date.formatter(for: format, timeZone: TimeZone.current).string(from: Calendar.current.startOfDay(for: yesterday))
    }
    
    public func startOfMonth() -> Date? {
        let currentDateComponents:DateComponents = Calendar.current.dateComponents([.year, .month], from: self)
        let startOfMonth:Date? = Calendar.current.date(from: currentDateComponents)
        return startOfMonth
     }

    func dateByAddingDays(daysToAdd: Int) -> Date? {
       var days: DateComponents = DateComponents()
       days.day = daysToAdd
       return Calendar.current.date(byAdding: days, to: self)
    }
    
     func dateByAddingMonths(monthsToAdd: Int) -> Date? {
        var months: DateComponents = DateComponents()
        months.month = monthsToAdd
        return Calendar.current.date(byAdding: months, to: self)
     }

    public func endOfMonth() -> Date? {
        if let plusOneMonthDate = dateByAddingMonths(monthsToAdd: 1) {
            let plusOneMonthDateComponents = Calendar.current.dateComponents([.year, .month], from: plusOneMonthDate)
            let endOfMonth = Calendar.current.date(from: plusOneMonthDateComponents)?.addingTimeInterval(-1)
            return endOfMonth
        }
        return nil
    }
    
    private static func baseFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        return formatter
    }
    
    func string(for format: Format, timeZone: TimeZone = TimeZone.current) -> String {
        return Date.formatter(for: format).string(from: self)
    }
    
    static func formatter(for format: Format, timeZone: TimeZone = TimeZone.current) -> DateFormatter {
        var formatter: DateFormatter
        
        switch format {
        case .backendMid:
            formatter = Date.backendMidFormatter
        case .backend:
            formatter = Date.backendFormatter
        case .default:
            formatter = Date.defaultFormatter
        case .hour:
            formatter = Date.hourFormatter
        case .minute:
            formatter = Date.minuteFormatter
        case .dateShort:
            formatter = Date.dateShortFormatter
        case .dayShort:
            formatter = Date.dayShortFormatter
        case .timeShort:
            formatter = Date.timeShortFormatter
        case .backendShort:
            formatter = Date.backendShortFormatter
        case .title:
            formatter = Date.titleFormatter
        case .timeLong:
            formatter = Date.dateDetailShortFormatter
        case .timeMidium:
            formatter = Date.timeMidiumFormatter
        case .time24:
            formatter = Date.time24Formatter
        case .time12:
            formatter = Date.time12Formatter
        case .time24Seconds:
            formatter = Date.time24SecondsFormatter
        case .dateAndTime:
            formatter = Date.dateAndTimeFormatter
        case .monthYear:
            formatter = Date.monthYearFormatter
        }
        
        formatter.timeZone = timeZone
        return formatter
    }
    
    var minutes: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var weekday: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    var isToday: Bool {
        return Calendar.current.component(.day, from: self) == Calendar.current.component(.day, from: Date())
    }
    
    var isThisYear: Bool {
        return Calendar.current.component(.year, from: self) == Calendar.current.component(.year, from: Date())
    }
    
    var commentDate: String {
        return Date.formatter(for: isThisYear ? isToday ? .timeShort : .timeMidium : .timeLong).string(from: self)
    }
}
