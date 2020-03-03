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

public typealias TimerStore = Store<TimerState, TimerAction>

public class TimerViewController: UIViewController
{    
    private var bottomSheet: BottomSheet!
    private var timeLog: TimeLogViewController!
    
    public var store: TimerStore!
    public var startEditViewController: StartEditViewController!
        
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Timer"
        navigationController?.navigationBar.prefersLargeTitles = true

        timeLog = TimeLogViewController.instantiate()
        timeLog.store = store
        install(timeLog)
        
        bottomSheet = BottomSheet(viewController: startEditViewController)
        install(bottomSheet, customConstraints: true)
    }
    
    public override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        store.dispatch(.load)
    }
    
    public override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        timeLog.additionalSafeAreaInsets.bottom = bottomSheet.view.frame.height
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
