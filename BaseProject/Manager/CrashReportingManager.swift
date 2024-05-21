//
//  CrashReportingManager.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 20/05/24.
//

import Foundation
import FirebaseCrashlytics

class CrashReportingManager {
    static let shared = CrashReportingManager()

    private init() {}

    /// Logs a non-fatal error to Firebase Crashlytics
    /// - Parameters:
    ///   - error: The error to log
    ///   - userInfo: Additional information to include with the error
    func logError(_ error: Error, userInfo: [String: Any]? = nil) {
        Crashlytics.crashlytics().record(error: error)
        if let userInfo = userInfo {
            userInfo.forEach { key, value in
                Crashlytics.crashlytics().setCustomValue(value, forKey: key)
            }
        }
    }

    /// Logs a custom message to Firebase Crashlytics
    /// - Parameter message: The message to log
    func logMessage(_ message: String) {
        Crashlytics.crashlytics().log(message)
    }

    /// Logs a custom event to Firebase Crashlytics
    /// - Parameters:
    ///   - name: The name of the event
    ///   - parameters: Additional parameters to include with the event
    func logEvent(_ name: String, parameters: [String: Any]? = nil) {
        let event = parameters?.map { "\($0.key): \($0.value)" }.joined(separator: ", ") ?? ""
        logMessage("Event - \(name): \(event)")
    }
}
