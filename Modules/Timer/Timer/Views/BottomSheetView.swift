//
//  BottomSheetView.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 27/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Utils
import Assets

class BottomSheetView: UIView
{
    private var bottomConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    private var parentViewController: UIViewController
    
    public var stops: [CGFloat] = [77]
    private var layedOut: Bool = false
    
    public var containedViewController: UIViewController?
    {
        didSet {
            guard let viewController = containedViewController else { return }
            
            parentViewController.addChild(viewController)
            addSubview(viewController.view)
            viewController.didMove(toParent: parentViewController)
            
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.topAnchor.constraint(equalTo: topAnchor).isActive = true
            viewController.view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
            viewController.view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            viewController.view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(parentViewController: UIViewController)
    {
        self.parentViewController = parentViewController
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        addGestureRecognizer(gesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func didMoveToSuperview()
    {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomConstraint = bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: 10) // 10 to hide the bottom rounded corners
        bottomConstraint.isActive = true
        heightConstraint = heightAnchor.constraint(equalToConstant: stops.first! + 10)
        heightConstraint.isActive = true
        
        backgroundColor = .white
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard !layedOut else { return }
        layedOut = true
        
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
        layer.shadowOffset = CGSize(width: 0, height: -6)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.2
    }
    
    @objc
    func panGesture(recognizer: UIPanGestureRecognizer)
    {
        let translation = recognizer.translation(in:self)
        
        switch recognizer.state {
        case .changed:
            heightConstraint.constant -= translation.y
            
        case .ended, .cancelled:
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    self.heightConstraint.constant = self.stops.first!
                    self.superview?.layoutIfNeeded()
            },
                completion:  nil)
        default:
            break
        }
        
        recognizer.setTranslation(CGPoint.zero, in: self)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification)
    {
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrame =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
                        
        self.bottomConstraint.constant = -keyboardFrame.height + 10 + safeAreaLayoutGuide.layoutFrame.height
        self.superview?.layoutIfNeeded()
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification)
    {
        self.heightConstraint.constant = 10
        self.superview?.layoutIfNeeded()
    }
}
