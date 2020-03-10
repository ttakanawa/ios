//
//  OnboardingCoordinator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public final class OnboardingCoordinator: Coordinator {
public var route: AppRoute = .onboarding(.start)

    private var store: Store<OnboardingState, OnboardingAction>
    public var rootViewController: UIViewController

    public init(rootViewController: UIViewController, store: Store<OnboardingState, OnboardingAction>) {
        self.store = store
        self.rootViewController = rootViewController
    }

    public func newRoute(route: String) {
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

    public func finish(completion: (() -> Void)? = nil) {
        completion?()
        //TODO FINISH CHILDREN
    }
}
