//
//  TimerCoordinator.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import Models

public typealias TimerStore = Store<TimerState, TimerAction>

public class TimerCoordinator: Coordinator
{
    private let navigationController: UINavigationController
    private let store: TimerStore
    
    public var loggedIn: (() -> ())?
            
    public init(navigationController: UINavigationController, store: TimerStore)
    {
        self.navigationController = navigationController
        self.store = store
    }
    
    public func start()
    {
        let Timer = TimerViewController.instantiate()
        Timer.coordinator = self
        Timer.store = store
        navigationController.pushViewController(Timer, animated: true)
    }
}
