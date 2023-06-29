//
//  Colors.swift
//  SharedUI
//
//  Created by hoseinAlimoradi on 6/28/23.
//

import UIKit
public enum Colors {
    
    public enum Primary {
        public static let primary = UIColor(hexValue: 0x6a5acd)
        public static let primaryLight = UIColor(hexValue: 0xF8F8FF)
    }
    
    public enum Secondary {
        public static let secondary = UIColor(hexValue: 0x73C2FB)
        public static let secondaryLight = UIColor(hexValue: 0xF0F8FF)
    }
    
    public enum Third {
        public static let third = UIColor(hexValue: 0x9F2B68)
        public static let thirdLight = UIColor(hexValue: 0xFDD7E4)
    }
    
    public enum PastilColor {
        public static let purple = UIColor(hexValue: 0xf8f4ff)
        public static let pink = UIColor(hexValue: 0xFFE4E1)
        public static let yellow = UIColor(hexValue: 0xF2D2BD)
        public static let cream = UIColor(hexValue: 0xfffdd0)
        public static let violet = UIColor(hexValue: 0xE0B0FF)
        public static let green = UIColor(hexValue: 0x3EB489)
    }
    
    public static let success = UIColor(hexValue: 0x228B22)
    public static let link = UIColor(hexValue: 0x005A9C)
    public static let warning = UIColor(hexValue: 0xF4C430)
    public static let error = UIColor(hexValue: 0xA42A04)
    
    public enum BlackPearl {
        public static let darkest = UIColor(hexValue: 0x080C12)
        public static let veryDark = UIColor(hexValue: 0x4b5a62)
        public static let dark = UIColor(hexValue: 0x1C1E1E)
        public static let medium = UIColor(hexValue: 0x849ca9)
        public static let light = UIColor(hexValue: 0xD9E4F5)
        public static let lightest = UIColor(hexValue: 0xd1e1e5)
    }
    
    public static let black = UIColor(hexValue: 0x000000)
    public static let white = UIColor(hexValue: 0xFFFFFF)
    public static let background = UIColor(hexValue: 0xF0F8FF)
    
    //
    
    static var gradientBackground: [CGColor] {
        if #available(iOS 13.0, *) {
            return [UIColor.systemGray4.cgColor, UIColor.systemGray5.cgColor, UIColor.systemGray5.cgColor]
        } else {
            return [UIColor(hexValue: 0xDADADE).cgColor, UIColor(hexValue: 0xEAEAEE).cgColor, UIColor(hexValue: 0xDADADE).cgColor]
        }
    }
    
    static var separator: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGray3
        } else {
            return UIColor(hexValue: 0xD1D1D6)
        }
    }
    
    static var text: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return UIColor(hexValue: 0x3993F8)
        }
    }
    
    static var accent: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBlue
        } else {
            return UIColor(hexValue: 0x3993F8)
        }
    }
}
//extension UIColor {
//    convenience init(_ hex: String, alpha: CGFloat = 1.0) {
//      var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//
//      if cString.hasPrefix("#") { cString.removeFirst() }
//
//      if cString.count != 6 {
//        self.init("ff0000") // return red color for wrong hex input
//        return
//      }
//
//      var rgbValue: UInt64 = 0
//      Scanner(string: cString).scanHexInt64(&rgbValue)
//
//      self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//                alpha: alpha)
//    }
//}

internal extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(hexValue: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hexValue >> 16) & 0xFF,
            green: (hexValue >> 8) & 0xFF,
            blue: hexValue & 0xFF,
            a: a
        )
    }
    
    static func adaptive(dark: UIColor, light: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
        } else {
            return light
        }
    }
}



