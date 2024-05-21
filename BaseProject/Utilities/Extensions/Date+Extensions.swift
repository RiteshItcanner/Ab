//
//  Date+Extensions.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 19/05/24.
//

import Foundation

extension Date {
    // MARK: - Properties

    var year: Int {
        return Calendar.current.component(.year, from: self)
    }

    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    var day: Int {
        return Calendar.current.component(.day, from: self)
    }

    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }

    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }

    var second: Int {
        return Calendar.current.component(.second, from: self)
    }

    // MARK: - Methods

    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }

    static func fromString(_ dateString: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }

    func addingDays(_ days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: self)
    }

    func addingHours(_ hours: Int) -> Date? {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)
    }

    func addingMinutes(_ minutes: Int) -> Date? {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)
    }

    func addingSeconds(_ seconds: Int) -> Date? {
        return Calendar.current.date(byAdding: .second, value: seconds, to: self)
    }
}

