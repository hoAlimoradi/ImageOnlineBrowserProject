//
//  ReusableCell.swift
//  SharedUI
//
//  Created by hoseinAlimoradi on 6/27/23.
//
import UIKit

public protocol ReusableCell: AnyObject {
    /// Reusable cell identifier.
    static var cellIdentifier: String { get }
}

extension ReusableCell {
    static public var cellIdentifier: String { className(of: self) }
}

public func className(of aClass: AnyObject) -> String {
    return String(describing: type(of: aClass))
}

public func className(of aClass: AnyClass) -> String {
    return String(describing: aClass.self)
}
