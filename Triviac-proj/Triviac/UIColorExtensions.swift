//
//  UIColorExtensions.swift
//  Triviac
//
//  Created by Anya Ji on 6/19/20.
//  Copyright © 2020 Anya Ji. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    static let bgcolor = UIColor(red: 0.27, green: 0.29, blue: 0.30, alpha: 1.00)
    static let accentbuttoncolor = UIColor(red: 0.96, green: 0.83, blue: 0.37, alpha: 1.00)
    static let btcolor = UIColor(red: 0.30, green: 0.31, blue: 0.33, alpha: 1.00)
    static let textcolor = UIColor.white
    static let bordercolor = UIColor.white
    static let shadowcolor = UIColor(red: 0.15, green: 0.16, blue: 0.16, alpha: 1.00)
    static let choicebuttoncolor = UIColor(red: 0.77, green: 0.76, blue: 0.78, alpha: 1.00)
    static let slcolor = UIColor(red: 1.00, green: 0.75, blue: 0.27, alpha: 1.00)
    static let correctcolor = UIColor(red: 0.54, green: 0.80, blue: 0.53, alpha: 1.00)
    static let borderslcolor = UIColor(red: 0.93, green: 0.54, blue: 0.20, alpha: 1.00)
    static let bordercorrectcolor = UIColor(red: 0.45, green: 0.76, blue: 0.44, alpha: 1.00)
    static let tiecolor = UIColor(red: 0.37, green: 0.34, blue: 0.41, alpha: 1.00)
    static let confetticolors =
        [UIColor(red: 0.96, green: 0.56, blue: 0.59, alpha: 1.00), //pink
            UIColor(red: 0.99, green: 0.98, blue: 0.18, alpha: 1.00), //yellow
            UIColor(red: 0.87, green: 0.70, blue: 0.96, alpha: 1.00), //purple
            UIColor(red: 0.95, green: 0.96, blue: 1.00, alpha: 1.00), //white
            UIColor(red: 0.33, green: 0.84, blue: 0.76, alpha: 1.00) // blue
    ]
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
    }
    
    // MARK: - Initialization
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    // MARK: - Computed Properties
    
    var toHex: String? {
        return toHex()
    }
    
    // MARK: - From UIColor to String
    
    func toHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
}
