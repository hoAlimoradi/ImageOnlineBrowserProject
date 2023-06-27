//
//  Coordinator.swift
//  Commons
//
//  Created by hoseinAlimoradi on 6/23/23.
//
import Foundation
import UIKit

protocol Router {
    var viewController: UIViewController? { get set }
}

public protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    init(navigationController: UINavigationController?)
}

public struct Exchange: Codable {
    public let rates: [String: Double]
    public let base, date: String
}
 
