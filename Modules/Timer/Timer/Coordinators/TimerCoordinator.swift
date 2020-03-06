//
//  TimerCoordinator.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public final class TimerCoordinator: Coordinator
{
    private var store: Store<TimerState, TimerAction>
    public var rootViewController: UIViewController!
    
    private let timeLogCoordinator: TimeLogCoordinator
    private let startEditCoordinator: StartEditCoordinator
    
    public init(store: Store<TimerState, TimerAction>, timeLogCoordinator: TimeLogCoordinator, startEditCoordinator: StartEditCoordinator)
    {
        self.store = store
        self.timeLogCoordinator = timeLogCoordinator
        self.startEditCoordinator = startEditCoordinator
    }
    
    public func start(presentingViewController: UIViewController)
    {
        timeLogCoordinator.start(presentingViewController: presentingViewController)
        startEditCoordinator.start(presentingViewController: presentingViewController)
        let vc = TimerViewController()
        vc.timeLogViewController = timeLogCoordinator.rootViewController as? TimeLogViewController
        vc.startEditViewController = startEditCoordinator.rootViewController as? StartEditViewController
        presentingViewController.show(vc, sender: nil)
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
