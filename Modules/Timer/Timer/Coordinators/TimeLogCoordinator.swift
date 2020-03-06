//
//  TimeLogCoordinator.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public final class TimeLogCoordinator: BaseCoordinator
{
    private var store: Store<TimeLogState, TimeLogAction>
    public init(store: Store<TimeLogState, TimeLogAction>)
    {
        self.store = store
    }
    
    public override func start()
    {
        let vc = TimeLogViewController.instantiate()
        vc.store = store
        self.rootViewController = vc
    }
}
