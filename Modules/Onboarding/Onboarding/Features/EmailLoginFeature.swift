//
//  EmailLoginFeature.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 05/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import API

public class EmailLoginFeature: BaseFeature<OnboardingState, EmailLoginAction, UserAPI>
{
    public override var reducer: Reducer<OnboardingState, EmailLoginAction, UserAPI> {
        return emailLoginReducer
    }
    
    public override func mainCoordinator(store: Store<OnboardingState, EmailLoginAction>) -> Coordinator {
        return EmailLoginCoordinator(store: store)
    }
}

