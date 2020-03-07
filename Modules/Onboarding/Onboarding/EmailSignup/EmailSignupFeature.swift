//
//  EmailSignupFeature.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 05/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture

class EmailSignupFeature: BaseFeature<OnboardingState, EmailSignupAction>
{
    override func mainCoordinator(store: Store<OnboardingState, EmailSignupAction>) -> Coordinator {
        return EmailSignupCoordinator(store: store)
    }
}
