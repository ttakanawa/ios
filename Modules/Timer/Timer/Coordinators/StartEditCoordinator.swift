//
//  StartEditCoordinator.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public final class StartEditCoordinator: Coordinator
{
    private var store: Store<StartEditState, StartEditAction>
    public var rootViewController: UIViewController!
        
    public init(store: Store<StartEditState, StartEditAction>)
    {
        self.store = store
    }
    
    public func start(presentingViewController: UIViewController)
    {
        let vc = StartEditViewController.instantiate()
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
