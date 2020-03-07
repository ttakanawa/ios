//
//  StartEditCoordinator.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public final class StartEditCoordinator: BaseCoordinator
{
    private var store: Store<StartEditState, StartEditAction>
        
    public init(store: Store<StartEditState, StartEditAction>)
    {
        self.store = store
    }
    
    public override func start()
    {
        let vc = StartEditViewController.instantiate()
        vc.store = store
        self.rootViewController = vc
    }
}
