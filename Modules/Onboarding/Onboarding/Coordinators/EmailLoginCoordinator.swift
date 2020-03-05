//
//  EmailLoginCoordinator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public final class EmailLoginCoordinator: Coordinator
{
    public var rootViewController: UIViewController!
    
    private var store: Store<OnboardingState, EmailLoginAction>
    private var navigationController: UINavigationController?
        
    public init(store: Store<OnboardingState, EmailLoginAction>) {
        self.store = store
    }
    
    public func start(presentingViewController: UIViewController)
    {
        let vc = LoginViewController.instantiate()
        vc.store = store
        self.navigationController = UINavigationController(rootViewController: vc)
        self.rootViewController = navigationController
        presentingViewController.present(navigationController!, animated: true)
    }
    
    public func newRoute(route: String) -> Coordinator?
    {
        guard let route = OnboardingRoute(rawValue: route) else { fatalError() }
        
        return nil
//
//        switch route {
//        case "start":
//            let vc = LoginViewController.instantiate()
//            vc.store = store
//
//            navigationViewController = UINavigationController(rootViewController: vc)
//            presentingViewController.present(navigationViewController!, animated: true)
//        default:
//            fatalError("Wrong path")
//        }
    }
    
    public func finish(completion: (() -> Void)?)
    {
        navigationController?.dismiss(animated: true, completion: completion)
    }
}
