//
//  EmailLoginCoordinator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import Onboarding

public final class EmailLoginCoordinator: Coordinator
{
    private var store: Store<AppState, AppAction>
    private var presentingViewController: UIViewController
    private var navigationVieWController: UINavigationController?
        
    public init(presentingViewController: UIViewController, store: Store<AppState, AppAction>) {
        self.store = store
        self.presentingViewController = presentingViewController
        
        super.init("emailLogin")
    }
    
    public override func newRoute(route: String)
    {
        switch route {
        case "start":
            let vc = LoginViewController.instantiate()
            vc.store = store.view(
                state: { $0.onboardingState },
                action: { .onboarding(.emailLogin($0)) }
            )
            
            navigationVieWController = UINavigationController(rootViewController: vc)
            presentingViewController.present(navigationVieWController!, animated: true)
        default:
            fatalError("Wrong path")
        }
    }
    
    public override func finish(completion: (() -> Void)?)
    {
        navigationVieWController?.dismiss(animated: true, completion: completion)
    }
}
