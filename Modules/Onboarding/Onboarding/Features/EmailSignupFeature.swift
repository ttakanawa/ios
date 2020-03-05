//
//  EmailSignupFeature.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 05/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture
import API

public class EmailSignupFeature: BaseFeature<OnboardingState, EmailSignupAction, UserAPI>
{
    public override var reducer: Reducer<OnboardingState, EmailSignupAction, UserAPI> {
        return emailSignupReducer
    }
    
    public override func mainCoordinator(store: Store<OnboardingState, EmailSignupAction>) -> Coordinator {
        return EmailSignupCoordinator(store: store)
    }
}
