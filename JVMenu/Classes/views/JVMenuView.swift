//
//  JVMenuView.swift
//  JVMenu
//
//  Created by Jorge Valbuena on 2020-05-10.
//

import UIKit

public protocol JVMenuViewDelegate: class {
    /// This function will provide call back for the item selected in the menu.
    func selectedMenuItem(row: Int)
}

public class JVMenuView: UIView {
    
    /// Shared instance
    public static var shared: JVMenuView = JVMenuView(frame: CGRect(x: 0,
                                                                    y: 0,
                                                                    width: UIScreen.main.bounds.size.width,
                                                                    height: UIScreen.main.bounds.size.height))
    
    public var data: JVMenuDataModel? {
        didSet {
            setupView()
        }
    }
    
    public weak var delegate: JVMenuViewDelegate?
    
    private struct Constants {
        static let offSetPercentage: CGFloat = 0.4
        static let restPercentage: CGFloat = 0.6
        static let animationInterval: TimeInterval = 0.3
    }
    
    private lazy var shadowView: UIView = {
        let view: UIView = UIView(frame: shadowViewFrame)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.isUserInteractionEnabled = true
        view.alpha = 0.0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        return view
    }()
    
    private var shadowViewFrame: CGRect {
        return CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
        
    private lazy var continerView: JVMenuContainerView = {
        let view: JVMenuContainerView = JVMenuContainerView(frame: shownContainerViewFrame, data: data!)
        view.delegate = self
        view.isUserInteractionEnabled = true
        view.alpha = 0.0
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        return view
    }()
        
    private var hiddenContainerViewFrame: CGRect {
        return CGRect(x: 0, y: frame.maxY, width: frame.size.width, height: 0)
    }
    
    private var shownContainerViewFrame: CGRect {
        let originY: CGFloat = frame.size.height*Constants.offSetPercentage
        let height: CGFloat = frame.size.height*Constants.restPercentage
        return CGRect(x: 0, y: originY, width: frame.size.width, height: height)
    }
    
    private var isPanGestureAnimating: Bool = false
    private var originYTracker: CGFloat = 0
    
    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        // return if animating
        if isPanGestureAnimating { return }
        
        // reset container if gesture state is cancelled, ended or failed
        if gestureRecognizer.state == .cancelled || gestureRecognizer.state == .ended || gestureRecognizer.state == .failed {
            resetContainerStateAnimated()
        } else {
            // getting point and setting up new frame for the container
            let translationY = gestureRecognizer.translation(in: continerView).y
            let positiveTranslationY = abs(translationY)
            var containerFrame: CGRect = shownContainerViewFrame
            let newOriginY: CGFloat = containerFrame.origin.y+translationY
            let newHeight: CGFloat = containerFrame.size.height+positiveTranslationY
            let rect: CGRect = CGRect(x: 0, y: newOriginY, width: containerFrame.size.width, height: newHeight)
            
            // check if the container has been slide up (max to -60 points)
            if translationY > -60 && translationY <= 0 {
                continerView.frame = rect
                shadowView.alpha = 1
            } else if translationY > 0 {
                // if container is sliding down update container frame accordingly
                continerView.frame = rect
                let newAlpha: CGFloat = 100/translationY // this will perform the alpha fade based on percentage
                shadowView.alpha = newAlpha
                
                // if we reach half way down then dismiss animated
                if translationY > (containerFrame.height/2) {
                    isPanGestureAnimating = true
                    hide {
                        self.isPanGestureAnimating = false
                        self.removeFromSuperview()
                    }
                }
            } else {
                // else we set the new frame and reset the state
                containerFrame.size.height = newHeight
                resetContainerStateAnimated(containerFrame)
            }
        }
    }
    
    private func resetContainerStateAnimated() {
        isPanGestureAnimating = true
        UIView.animate(withDuration: Constants.animationInterval, animations: {
            self.continerView.frame = self.shownContainerViewFrame
            self.shadowView.alpha = 1
        }) { (finished) in
            self.isPanGestureAnimating = false
        }
    }
    
    private func resetContainerStateAnimated(_ newFrame: CGRect) {
        isPanGestureAnimating = true
        UIView.animate(withDuration: Constants.animationInterval, animations: {
            self.continerView.frame = newFrame
            self.shadowView.alpha = 1
        }) { (finished) in
            self.continerView.frame = self.shownContainerViewFrame
            self.isPanGestureAnimating = false
        }
    }
    
    @objc private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        hide {
            self.removeFromSuperview()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        continerView.jvmenu_roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
    }
    
    private func setupView() {
        addSubview(shadowView)
        addSubview(continerView)
    }
    
    public func show() {
        continerView.frame = hiddenContainerViewFrame
        continerView.isHidden = false
        shadowView.isHidden = false
        UIView.animate(withDuration: Constants.animationInterval, animations: {
            self.continerView.frame = self.shownContainerViewFrame
            self.continerView.alpha = 1
            self.shadowView.alpha = 1
        }) { (finished) in
        }
    }
    
    public func hide(completion: @escaping () -> Void) {
        UIView.animate(withDuration: Constants.animationInterval, animations: {
            self.continerView.frame = self.hiddenContainerViewFrame
            self.continerView.alpha = 0
            self.shadowView.alpha = 0
        }) { (finished) in
            self.continerView.isHidden = true
            self.shadowView.isHidden = true
            completion()
        }
    }
}

extension JVMenuView: JVMenuContainerViewDelegate {
    func selectedItemAt(row: Int) {
        if delegate != nil {
            delegate?.selectedMenuItem(row: row)
            hide {
                self.removeFromSuperview()
            }
        }
    }
}

extension UIView {
   func jvmenu_roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
