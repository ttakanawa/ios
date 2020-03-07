//
//  TimerCoordinator.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public final class TimerCoordinator: NavigationCoordinator
{
    private var store: Store<TimerState, TimerAction>
    
    private let timeLogCoordinator: TimeLogCoordinator
    private let startEditCoordinator: StartEditCoordinator
    
    public init(store: Store<TimerState, TimerAction>, timeLogCoordinator: TimeLogCoordinator, startEditCoordinator: StartEditCoordinator)
    {
        self.store = store
        self.timeLogCoordinator = timeLogCoordinator
        self.startEditCoordinator = startEditCoordinator
    }
    
    public override func start()
    {
        timeLogCoordinator.start()
        startEditCoordinator.start()
        let vc = TimerViewController()
        vc.timeLogViewController = timeLogCoordinator.rootViewController as? TimeLogViewController
        vc.startEditViewController = startEditCoordinator.rootViewController as? StartEditViewController
        navigationController.pushViewController(vc, animated: true)
    }
}
