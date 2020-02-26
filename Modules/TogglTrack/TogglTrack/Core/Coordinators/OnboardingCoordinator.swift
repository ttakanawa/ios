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
    private var window: UIWindow
    private var rootViewController: UIViewController? {
        didSet {
            window.rootViewController = rootViewController!
            window.makeKeyAndVisible()
        }
    }
    
    public init(window: UIWindow, store: Store<AppState, AppAction>) {
        self.store = store
        self.window = window
        
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

            rootViewController = vc
        default:
            fatalError("Wrong path")
            break
        }
    }
    
    public override func childForPath(_ path: String) -> Coordinator?
    {
        switch path {
        case "emailLogin":
            return EmailLoginCoordinator(presentingViewController: rootViewController!, store: store)
        case "emailSignup":
            return EmailSignupCoordinator(presentingViewController: rootViewController!, store: store)
        default:
            fatalError("Wrong path")
        }
    }
}
