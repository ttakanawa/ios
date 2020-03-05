//
//  OnboardingFeature.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 05/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import API

let emailLoginFeature: BaseFeature<OnboardingState, OnboardingAction, UserAPI> = EmailLoginFeature()
    .wrap(
        pullback: { $0.pullback(
            action: \OnboardingAction.emailLogin
            )},
        viewStore: { $0.view(
            state: { $0 },
            action: { OnboardingAction.emailLogin($0) }
            )}
    )

let emailSignupFeature: BaseFeature<OnboardingState, OnboardingAction, UserAPI> = EmailSignupFeature()
    .wrap(
        pullback: { $0.pullback(
            action: \OnboardingAction.emailSignup
            )},
        viewStore: { $0.view(
            state: { $0 },
            action: { OnboardingAction.emailSignup($0) }
            )}
    )

public class OnboardingFeature: BaseFeature<OnboardingState, OnboardingAction, UserAPI>
{
    let features: [String: BaseFeature<OnboardingState, OnboardingAction, UserAPI>] = [
        OnboardingRoute.emailLogin.rawValue: emailLoginFeature,
        OnboardingRoute.emailSignup.rawValue: emailSignupFeature
    ]
    
    public override var reducer: Reducer<OnboardingState, OnboardingAction, UserAPI> {
        return combine(
            [onboardingReducer] + features.values.map{ $0.reducer }
        )
    }
    
    public override func mainCoordinator(store: Store<OnboardingState, OnboardingAction>) -> Coordinator {
        return OnboardingCoordinator(store: store, features: features)
    }
}
