//
//  TimeEntriesLogCoordinator.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public final class TimeEntriesLogCoordinator: BaseCoordinator
{
    private var store: Store<TimeEntriesLogState, TimeEntriesLogAction>
    public init(store: Store<TimeEntriesLogState, TimeEntriesLogAction>)
    {
        self.store = store
    }
    
    public override func start()
    {
        let vc = TimeEntriesLogViewController.instantiate()
        vc.store = store
        self.rootViewController = vc
    }
}
