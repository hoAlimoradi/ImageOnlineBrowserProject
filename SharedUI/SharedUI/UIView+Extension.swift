//
//  UIView+Extension.swift
//  SharedUI
//
//  Created by hoseinAlimoradi on 6/27/23.
//
import UIKit

extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
}

extension UIView {

    // MARK: - Shadow

    public func setShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(rect: bounds.insetBy(dx: 8, dy: 0)).cgPath
    }

    public func setShadow(opacity: Float = 1, radius: CGFloat, shadowColor: CGColor, shadowOffset: CGSize) {
        layer.masksToBounds = false
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
    }

    public func roundCorners(corners: UIRectCorner, radius: CGSize, roundedRect: CGRect) {
        let maskPath = UIBezierPath(
            roundedRect: roundedRect,
            byRoundingCorners: corners,
            cornerRadii: radius
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath

        layer.mask = maskLayer
    }

    public func roundCorners(corners: UIRectCorner, radius: CGFloat, bgColor: UIColor = .white, cornerCurve: CALayerCornerCurve = .continuous, shadowColor: UIColor = .clear, shadowOffset: CGSize = CGSize.zero, shadowOpacity: Float = 0, shadowRadius: CGFloat = 0, boundsInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        let shape = CAShapeLayer()
        shape.name = "shape"
        let path = UIBezierPath(roundedRect: bounds.inset(by: boundsInset), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        shape.bounds = frame
        shape.position = center
        shape.path = path.cgPath
        shape.fillColor = bgColor.cgColor
        shape.shadowColor = shadowColor.cgColor
        shape.shadowPath = shape.path
        shape.shadowOffset = shadowOffset
        shape.shadowOpacity = shadowOpacity
        shape.shadowRadius = shadowRadius
        guard layer.sublayers?.filter({$0.name == "shape"}).first == nil else {
            return
        }
        layer.cornerCurve = cornerCurve
        layer.insertSublayer(shape, at: 0)
    }
    // MARK: - add swipe Gesture
    public func addSwipeGestureAllDirection(action: Selector) {

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: action)
        swipeLeft.direction = .left
        swipeLeft.numberOfTouchesRequired = 1
        addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: action)
        swipeRight.direction = .right
        swipeRight.numberOfTouchesRequired = 1
        addGestureRecognizer(swipeRight)

        let swipeUp = UISwipeGestureRecognizer(target: self, action: action)
        swipeUp.direction = .up
        swipeUp.numberOfTouchesRequired = 1
        addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: action)
        swipeDown.direction = .down
        swipeDown.numberOfTouchesRequired = 1
        addGestureRecognizer(swipeDown)
    }
    public func showWithAnimation(duration: TimeInterval = 0.3,
                           options: UIView.AnimationOptions = [.curveEaseIn]) {
        guard self.isHidden else { return }
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: options,
            animations: {
                self.isHidden = false
                self.alpha = 1
            })
    }

    public func hideWithAnimation(duration: TimeInterval = 0.3,
                           options: UIView.AnimationOptions = [.curveEaseOut]) {
        guard !self.isHidden else { return }
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: options,
            animations: { [weak self] in
                self?.isHidden = true
                self?.alpha = 0
            })
    }
}

extension UIView {
    public func makeContextPreview() -> UIContextMenuContentPreviewProvider {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .clear
        viewController.view = self
        viewController.preferredContentSize = self.frame.size
        return { viewController }
    }
}

extension UIView {
    public class func animateCornerRadii(withDuration duration: TimeInterval, to value: CGFloat, views: [UIView], completion: ((Bool) -> Void)? = nil) {
        if views.count == 0 {
            completion?(true)
            return
        }

        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?(true)
        }

        for view in views {
            view.layer.masksToBounds = true

            let animation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            animation.fromValue = view.layer.cornerRadius
            animation.toValue = value
            animation.duration = duration

            view.layer.add(animation, forKey: "CornerRadiusAnim")
            view.layer.cornerRadius = value
        }
        CATransaction.commit()
    }
}

extension UIView {
    public func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}


extension UIView {
    public func setOnClickListener(action :@escaping () -> Void){
        let tapRecogniser = ClickListener(target: self, action: #selector(onViewClickedFuc(sender:)))
        tapRecogniser.onClick = action
        self.addGestureRecognizer(tapRecogniser)
    }

    @objc public func onViewClickedFuc(sender: ClickListener) {
        if let onClick = sender.onClick {
            onClick()
        }
    }
}
public class ClickListener: UITapGestureRecognizer {
    public var onClick : (() -> Void)? = nil
}

extension UIView {

    public func addTopRoundedCornerToView(desiredCurve: CGFloat?) {
        let offset: CGFloat = frame.width/desiredCurve!
        let bounds: CGRect = bounds

        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y+bounds.size.height / 2, width: bounds.size.width, height: bounds.size.height / 2)

        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)

        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath

        // Set the newly created shape layer as the mask for the view's layer
        layer.mask = maskLayer
    }
}


