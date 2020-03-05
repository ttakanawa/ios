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

public class OnboardingFeature: BaseFeature<OnboardingState, OnboardingAction, UserAPI>
{    
    public override var reducer: Reducer<OnboardingState, OnboardingAction, UserAPI> {
        return combine(
            onboardingReducer,
            emailLoginReducer.pullback(action: \OnboardingAction.emailLogin),
            emailSignupReducer.pullback(action: \OnboardingAction.emailSignup) 
        )
    }
    
    public override func mainCoordinator(rootViewController: UIViewController, store: Store<OnboardingState, OnboardingAction>) -> Coordinator {
        return OnboardingCoordinator(rootViewController: rootViewController, store: store)
    }
}
