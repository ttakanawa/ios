//
//  EmailLoginCoordinator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public final class EmailLoginCoordinator: NavigationCoordinator
{
    private var store: Store<OnboardingState, EmailLoginAction>
        
    public init(store: Store<OnboardingState, EmailLoginAction>) {
        self.store = store
        super.init()
    }
    
    public override func start()
    {
        let vc = LoginViewController.instantiate()
        vc.store = store
        navigationController.pushViewController(vc, animated: true)
    }
    
    override public func newRoute(route: String) -> Coordinator?
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
}
