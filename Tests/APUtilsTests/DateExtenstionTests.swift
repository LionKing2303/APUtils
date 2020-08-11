//
//  DateExtenstionTests.swift
//  Time2TimeTests
//
//  Created by Arie Peretz on 07/08/2020.
//  Copyright © 2020 Arie Peretz. All rights reserved.
//

import XCTest
@testable import APUtils

class DateExtenstionTests: XCTestCase {

    func test_all_date_formats() {
        let date: Date = Date()
        for format in Date.Format.allCases {
            
            let expectedString = date.string(for: format)
            
            let formatter: DateFormatter = Date.formatter(for: format)
            let string: String = formatter.string(from: date)
            
            XCTAssertEqual(string, expectedString)
        }
        
    }
    
    func test_start_of_month() {
        let now: Date = Date()
        
        if let date = now.startOfMonth() {
            let day: Int = Calendar.current.component(.day, from: date)
            XCTAssertEqual(day, 1)
        }
    }
    
    func test_end_of_month() {
        let now: Date = Date()
        var dateComponents: DateComponents = Calendar.current.dateComponents([.month], from: now)
        dateComponents.month = 3
        let marchDate: Date? = Calendar.current.date(from: dateComponents)
        
        if let date = marchDate?.endOfMonth() {
            let day: Int = Calendar.current.component(.day, from: date)
            XCTAssertEqual(day, 31)
        }   
        
    }
    
    func test_date_by_adding_days() {
        let now: Date = Date()
        var days: DateComponents = DateComponents()
        days.day = 1
        let expectedDate = Calendar.current.date(byAdding: days, to: now)
        let date = now.dateByAddingDays(daysToAdd: 1)
        
        XCTAssertEqual(date, expectedDate)
    }
    
    func test_minutes() {
        let date: Date = Date()
        let expectedMinutes: Int = Calendar.current.component(.minute, from: date)
        let minutes: Int = date.minutes
        XCTAssertEqual(minutes, expectedMinutes)
    }
    
    func test_day() {
        let date: Date = Date()
        let expectedDay: Int = Calendar.current.component(.day, from: date)
        let day: Int = date.day
        XCTAssertEqual(day, expectedDay)
    }
    
    func test_weekday() {
        let date: Date = Date()
        let expectedWeekday: Int = Calendar.current.component(.weekday, from: date)
        let weekday: Int = date.weekday
        XCTAssertEqual(weekday, expectedWeekday)
    }
    
    func test_hour() {
        let date: Date = Date()
        let expectedHour: Int = Calendar.current.component(.hour, from: date)
        let hour: Int = date.hour
        XCTAssertEqual(hour, expectedHour)
    }
    
    func test_is_today() {
        let date: Date = Date()
        let expectedIsToday: Bool = Calendar.current.component(.day, from: date) == Calendar.current.component(.day, from: Date())
        let isToday: Bool = date.isToday
        XCTAssertEqual(isToday, expectedIsToday)
    }
    
    func test_is_this_year() {
        let date: Date = Date()
        let expectedIsThisYear: Bool = Calendar.current.component(.year, from: date) == Calendar.current.component(.year, from: Date())
        let isThisYear: Bool = date.isThisYear
        XCTAssertEqual(isThisYear, expectedIsThisYear)
    }
    
    func test_comment_date() {
        let date: Date = Date()
        let expectedDate = Date.formatter(for: date.isThisYear ? date.isToday ? .timeShort : .timeMidium : .timeLong).string(from: date)
        let commentDate = date.commentDate
        XCTAssertEqual(commentDate, expectedDate)
    }
    
    func test_date_diff() {
        let now: Date = Date()
        let oneMinuteLater = now.addingTimeInterval(60)
        let expectedTimeInterval = oneMinuteLater.timeIntervalSinceReferenceDate - now.timeIntervalSinceReferenceDate
        let timeInterval = oneMinuteLater - now
        XCTAssertEqual(timeInterval, expectedTimeInterval)
    }
    
    func test_start_of_day() {
        let date:Date = Date()
        let defaultFormatter = Date.formatter(for: .default, timeZone: TimeZone.current)
        if let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date) {
            let expectedStartOfDay = defaultFormatter.string(from: Calendar.current.startOfDay(for:yesterday))
            let startOfDay = date.startOfDay(to: .default)
            XCTAssertEqual(startOfDay, expectedStartOfDay)
        }
    }
    
    func test_days_in() {
        let numberOfDays: Int = Date.days(in: 2020, and: 2)
        XCTAssertEqual(numberOfDays,29)
    }
    
    func test_wrong_days_in() {
        let numberOfDays: Int = Date.days(in: 2020, and: 2)
        XCTAssertNotEqual(numberOfDays,28)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
