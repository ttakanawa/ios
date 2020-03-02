//
//  OnboardingReducer.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture
import RxSwift
import API

let mainReducer = Reducer<OnboardingState, OnboardingAction, UserAPI> { state, action, api in
    
    switch action {
        
    case .emailSingInTapped:
        state.route = AppRoute.onboarding(.emailLogin(.start))
        break
        
    case .emailLogin(_):
        break
        
    case .emailSignup(_):
        break
    }

    return .empty
}


public let onboardingReducer = combine(
    mainReducer,
    emailLoginReducer.pullback(
        action: \OnboardingAction.emailLogin
    ),
    emailSignupReducer.pullback(
        action: \OnboardingAction.emailSignup
    )
)
