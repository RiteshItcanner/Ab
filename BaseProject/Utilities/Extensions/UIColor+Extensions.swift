//
//  UIColor+Extensions.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 19/05/24.
//

import UIKit

extension UIColor {
    /// Initialize UIColor with a hex string
    /// - Parameter hex: Hex string representation of the color
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        guard hexString.count == 6 else {
            self.init(white: 0.5, alpha: 1.0)
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    /// Generate a random color
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }

    /// Get hex string representation of the color
    var toHex: String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        let a = components.count >= 4 ? Float(components[3]) : 1.0
        
        if a == 1.0 {
            return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        } else {
            return String(format: "#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        }
    }

    /// Adjust the color's brightness
    /// - Parameter amount: The amount to adjust the brightness by (negative to darken, positive to brighten)
    func adjusted(by amount: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return self
        }
        
        return UIColor(
            red: min(max(red + amount, 0), 1),
            green: min(max(green + amount, 0), 1),
            blue: min(max(blue + amount, 0), 1),
            alpha: alpha
        )
    }

    /// Create a color from RGB values
    /// - Parameters:
    ///   - red: Red value (0-255)
    ///   - green: Green value (0-255)
    ///   - blue: Blue value (0-255)
    ///   - alpha: Alpha value (0-1, default is 1)
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }

    /// Create a color with the given grayscale value
    /// - Parameter white: Grayscale value (0-255)
    convenience init(white: Int) {
        assert(white >= 0 && white <= 255, "Invalid white component")
        
        self.init(
            white: CGFloat(white) / 255.0,
            alpha: 1.0
        )
    }
}

