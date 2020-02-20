//
//  TimeEntriesLogCoordinator.swift
//  TimeEntriesLog
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import Models

public typealias TimeEntriesLogStore = Store<TimeEntriesLogState, TimeEntriesLogAction>

public class TimeEntriesLogCoordinator: Coordinator
{
    private let navigationController: UINavigationController
    private let store: TimeEntriesLogStore
    
    public var loggedIn: (() -> ())?
            
    public init(navigationController: UINavigationController, store: TimeEntriesLogStore)
    {
        self.navigationController = navigationController
        self.store = store
    }
    
    public func start()
    {
        let timeEntriesLog = TimeEntriesLogViewController.instantiate()
        timeEntriesLog.coordinator = self
        timeEntriesLog.store = store
        navigationController.pushViewController(timeEntriesLog, animated: true)
    }
}
