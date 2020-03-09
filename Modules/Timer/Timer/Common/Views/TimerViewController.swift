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
    public var timeLogViewController: TimeEntriesLogViewController!

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
