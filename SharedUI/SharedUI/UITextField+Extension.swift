//
//  UITextField+Extension.swift
//  SharedUI
//
//  Created by hoseinAlimoradi on 6/27/23.
//

import Foundation
import UIKit
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}

extension UITextField {
    public func setLeftView(image: UIImage) {
    let iconView = UIImageView(frame: CGRect(x: 10, y: 10, width: 25, height: 25))
    iconView.image = image
    let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 45))
    iconContainerView.addSubview(iconView)
    leftView = iconContainerView
    leftViewMode = .always
    self.tintColor = .lightGray
  }
}

extension UITextField {
    public func placeholderColor(_ color: UIColor) {
            var placeholderText = ""
            if self.placeholder != nil{
                placeholderText = self.placeholder!
            }
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attributeString = [
                NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.6)
            ] as [NSAttributedString.Key : Any]
            self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributeString)
        }
     
}

extension UITextField{
    @IBInspectable var doneAccessory: Bool {
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }

    public func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc public func doneButtonAction() {
        self.resignFirstResponder()
    }
}

extension UITextField {

    public func setLeftPadding(_ amount: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.bounds.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    public func setRightPadding(_ amount: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.bounds.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}



