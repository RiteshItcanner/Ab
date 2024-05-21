//
//  String+Extensions.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 19/05/24.
//

import Foundation
import UIKit

extension String {
    /// Validate if the string is a valid email format
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    /// Trim whitespace and newline characters from the string
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Check if the string contains only numeric characters
    var isNumeric: Bool {
        return Double(self) != nil
    }

    /// Convert a string to a date with the specified format
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }

    /// Capitalize the first letter of the string
    var capitalizedFirst: String {
        return prefix(1).capitalized + dropFirst()
    }

    /// Check if the string contains only letters
    var isAlphabetic: Bool {
        let letters = CharacterSet.letters
        return self.unicodeScalars.allSatisfy { letters.contains($0) }
    }

    /// Check if the string contains only alphanumeric characters
    var isAlphanumeric: Bool {
        let alphanumeric = CharacterSet.alphanumerics
        return self.unicodeScalars.allSatisfy { alphanumeric.contains($0) }
    }

    /// Remove all non-alphanumeric characters from the string
    var removingNonAlphanumeric: String {
        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
    }

    /// URL encode the string
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }

    /// URL decode the string
    var urlDecoded: String? {
        return removingPercentEncoding
    }

    /// Convert a string to a Base64 encoded string
    var toBase64: String {
        return Data(self.utf8).base64EncodedString()
    }

    /// Convert a Base64 encoded string to a regular string
    var fromBase64: String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    /// Check if the string is a valid URL
    var isValidURL: Bool {
        guard let url = URL(string: self) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }

    /// Generate a random alphanumeric string of given length
    static func random(ofLength length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).compactMap { _ in characters.randomElement() })
    }
}

