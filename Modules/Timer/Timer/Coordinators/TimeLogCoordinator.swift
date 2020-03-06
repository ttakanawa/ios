//
//  TimeLogCoordinator.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public final class TimeLogCoordinator: Coordinator
{
    private var store: Store<TimeLogState, TimeLogAction>
    public var rootViewController: UIViewController!
        
    public init(store: Store<TimeLogState, TimeLogAction>)
    {
        self.store = store
    }
    
    public func start(presentingViewController: UIViewController)
    {
        let vc = TimeLogViewController.instantiate()
        vc.store = store
        self.rootViewController = vc
    }
    
    public func newRoute(route: String) -> Coordinator?
    {
        return nil
    }
    
    public func finish(completion: (() -> Void)? = nil)
    {
        completion?()
        //TODO FINISH CHILDREN
    }
}
