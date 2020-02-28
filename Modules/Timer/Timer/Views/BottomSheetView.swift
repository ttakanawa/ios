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
    public var stops: [CGFloat] = []
    
    private var heightConstraint: NSLayoutConstraint!
        
    init()
    {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        prepareBackgroundView()

        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview()
    {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor).isActive = true
        heightConstraint = heightAnchor.constraint(equalToConstant: 400)
        heightConstraint.isActive = true
    }
    
    private func prepareBackgroundView()
    {
        backgroundColor = UIColor.red // UIColor(white: 0.9, alpha: 1)
        layer.cornerRadius = 10
        
//        view.isOpaque = false
//        view.backgroundColor = UIColor(white: 1, alpha: 1)
//        view.layer.cornerRadius = 10
//        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: -6)
//        view.layer.shadowRadius = 2.0
//        view.layer.shadowOpacity = 0.2
//
//        if !UIAccessibility.isReduceTransparencyEnabled
//        {
//            view.backgroundColor = .clear
//
//            let blurEffect = UIBlurEffect(style: .extraLight)
//            let blurEffectView = UIVisualEffectView(effect: blurEffect)
//
//            blurEffectView.frame = self.view.bounds
//            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//            view.insertSubview(blurEffectView, at: 0)
//        } else {
//            view.backgroundColor = .black
//        }
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
                    self.heightConstraint.constant = 111
                    self.superview?.layoutIfNeeded()
                },
                completion:  nil)
        default:
            break
        }
    
        recognizer.setTranslation(CGPoint.zero, in: self)
    }

}
