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
    public var route: AppRoute = .onboarding(.emailLogin(.start))
    
    public var rootViewController: UIViewController {
        return navigationViewController!
    }
    
    private var store: Store<OnboardingState, EmailLoginAction>
    private var presentingViewController: UIViewController
    private var navigationViewController: UINavigationController?
        
    public init(presentingViewController: UIViewController, store: Store<OnboardingState, EmailLoginAction>) {
        self.store = store
        self.presentingViewController = presentingViewController
    }
    
    public func newRoute(route: String)
    {
        switch route {
        case "start":
            let vc = LoginViewController.instantiate()
            vc.store = store
            
            navigationViewController = UINavigationController(rootViewController: vc)
            presentingViewController.present(navigationViewController!, animated: true)
        default:
            fatalError("Wrong path")
        }
    }
    
    public func finish(completion: (() -> Void)?)
    {
        navigationViewController?.dismiss(animated: true, completion: completion)
    }
}
