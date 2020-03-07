//
//  EmailLoginFeature.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 05/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

class EmailLoginFeature: BaseFeature<OnboardingState, EmailLoginAction>
{
    override func mainCoordinator(store: Store<OnboardingState, EmailLoginAction>) -> Coordinator {
        return EmailLoginCoordinator(store: store)
    }
}

