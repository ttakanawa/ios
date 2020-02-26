//
//  OnboardingCoordinator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import Onboarding

public final class OnboardingCoordinator: Coordinator
{
    private var store: Store<AppState, AppAction>
    private var rootViewController: UIViewController
    
    public init(rootViewController: UIViewController, store: Store<AppState, AppAction>) {
        self.store = store
        self.rootViewController = rootViewController
        
        super.init("onboarding")
    }
    
    public override func newRoute(route: String)
    {
        switch route {
        case "start":
            let vc = OnboardingViewController.instantiate()
            vc.store = store.view(
                state: { $0.onboardingState },
                action: { .onboarding($0) }
            )

            rootViewController.show(vc, sender: nil)
        default:
            fatalError("Wrong path")
            break
        }
    }
    
    public override func childForPath(_ path: String) -> Coordinator?
    {
        switch path {
        case "emailLogin":
            return EmailLoginCoordinator(presentingViewController: rootViewController, store: store)
        case "emailSignup":
            return EmailSignupCoordinator(presentingViewController: rootViewController, store: store)
        default:
            fatalError("Wrong path")
        }
    }
    
    public override func finish(completion: (() -> Void)? = nil)
    {
        if let child = child {
            child.finish(completion: completion)
        } else {
            completion?()
        }
    }
}
