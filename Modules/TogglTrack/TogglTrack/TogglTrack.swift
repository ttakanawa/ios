//
//  TogglTrack.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 27/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import RxSwift
import Onboarding

public class TogglTrack
{
    private let store: Store<AppState, AppAction>
    private let router: Router
    private var disposeBag = DisposeBag()
    
    public init(coordinator: AppCoordinator)
    {
        store = buildStore()
        
        router = Router(initialCoordinator: coordinator)
        router.delegate = self

        store
            .select({ $0.route })
            .do(onNext: { print("Route: \($0.path)") })
            .distinctUntilChanged()
            .drive(onNext: router.navigate)
            .disposed(by: disposeBag)

        store.dispatch(.start)
    }
}

extension TogglTrack: RouterDelegate
{
    public func coordinator(forRoute route: String, rootViewController: UIViewController) -> Coordinator
    {
        switch route {
        case "onboarding":
            return OnboardingCoordinator(
                rootViewController: rootViewController,
                store: store.view(
                    state: { $0.onboardingState },
                    action: { .onboarding($0) }
                )
            )
            
        case "emailLogin":
            return EmailLoginCoordinator(
                presentingViewController: rootViewController,
                store: store.view(
                    state: { $0.onboardingState },
                    action: { .onboarding(.emailLogin($0)) }
                )
            )
        
        case "emailSignup":
            return EmailSignupCoordinator(
                presentingViewController: rootViewController,
                store: store.view(
                    state: { $0.onboardingState },
                    action: { .onboarding(.emailSignup($0)) }
                )
            )

        case "main":
            return TabBarCoordinator(
                rootViewController: rootViewController,
                store: store
            )
            
        default:
            fatalError("Wrong path")
        }
    }
}
