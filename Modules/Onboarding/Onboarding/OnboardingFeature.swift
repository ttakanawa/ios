//
//  OnboardingFeature.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 05/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public let onboardingReducer = combine(
    mainOnboardingReducer,
    emailLoginReducer.pullback(action: \OnboardingAction.emailLogin),
    emailSignupReducer.pullback(action: \OnboardingAction.emailSignup)
)

public class OnboardingFeature: BaseFeature<OnboardingState, OnboardingAction>
{
    let features = [
        OnboardingRoute.emailLogin.rawValue: EmailLoginFeature()
        .view { $0.view(
                state: { $0 },
                action: { OnboardingAction.emailLogin($0) })
        },
        OnboardingRoute.emailSignup.rawValue: EmailSignupFeature()
        .view { $0.view(
                state: { $0 },
                action: { OnboardingAction.emailSignup($0) })
        }
    ]
    
    public override func mainCoordinator(store: Store<OnboardingState, OnboardingAction>) -> Coordinator {
        return OnboardingCoordinator(store: store, features: features)
    }
}
