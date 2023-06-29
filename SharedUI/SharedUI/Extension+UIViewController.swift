//
//  Extension+UIViewController.swift
//  SharedUI
//
//  Created by hoseinAlimoradi on 6/27/23.
//
import UIKit
extension UIViewController {
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
}
