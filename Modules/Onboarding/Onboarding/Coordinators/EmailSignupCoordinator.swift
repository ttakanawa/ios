//
//  EmailSignupCoordinator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public final class EmailSignupCoordinator: Coordinator
{
    public var rootViewController: UIViewController!
        
    private var store: Store<OnboardingState, EmailSignupAction>
    private var navigationController: UINavigationController?
        
    public init(store: Store<OnboardingState, EmailSignupAction>) {
        self.store = store
    }
    
    public func start(presentingViewController: UIViewController)
    {
        let vc = SignupViewController.instantiate()
        vc.store = store
        self.navigationController = UINavigationController(rootViewController: vc)
        self.rootViewController = navigationController
        presentingViewController.present(navigationController!, animated: true)
    }
    
    public func newRoute(route: String) -> Coordinator?
    {
        return nil
//        switch route {
//        case "start":
//            let vc = SignupViewController.instantiate()
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
