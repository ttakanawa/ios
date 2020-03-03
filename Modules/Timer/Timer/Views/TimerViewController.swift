//
//  TimerViewController.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import Models
import RxCocoa
import RxSwift
import Utils
import Assets

public class TimerViewController: UIViewController
{    
    public var startEditViewController: StartEditViewController!
    public var timeLogViewController: TimeLogViewController!

    private var bottomSheet: BottomSheet!
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Timer"
        navigationController?.navigationBar.prefersLargeTitles = true

        install(timeLogViewController)
        
        bottomSheet = BottomSheet(viewController: startEditViewController)
        install(bottomSheet, customConstraints: true)
    }
    
    public override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        timeLogViewController.additionalSafeAreaInsets.bottom = bottomSheet.view.frame.height
    }
}


// TODO Move this somewhere else
public extension UIViewController {
    func install(_ child: UIViewController, customConstraints: Bool = false) {
        addChild(child)

        child.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(child.view)
        
        if !customConstraints {
            NSLayoutConstraint.activate([
                child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                child.view.topAnchor.constraint(equalTo: view.topAnchor),
                child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
        child.didMove(toParent: self)
    }
}
