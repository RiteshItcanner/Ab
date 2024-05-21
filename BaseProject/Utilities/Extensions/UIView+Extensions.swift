//
//  UIView+Extensions.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 19/05/24.
//

import UIKit

extension UIView {
    /// Add a border to the view
    /// - Parameters:
    ///   - color: The color of the border
    ///   - width: The width of the border
    func addBorder(color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    /// Round the corners of the view
    /// - Parameter radius: The radius to use when rounding the corners
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    /// Add a drop shadow to the view
    /// - Parameters:
    ///   - color: The color of the shadow
    ///   - opacity: The opacity of the shadow
    ///   - offset: The offset of the shadow
    ///   - radius: The radius of the shadow
    ///   - scale: Whether to scale the shadow for retina displays
    func addShadow(color: UIColor = .black,
                   opacity: Float = 0.5,
                   offset: CGSize = .zero,
                   radius: CGFloat = 1.0,
                   scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

