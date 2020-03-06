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

let onboardingScreenReducer = Reducer<OnboardingState, OnboardingAction, UserAPI> { state, action, api in
    
    switch action {
        
    case .emailSingInTapped:
        state.route = Route(path: "root/onboarding/emailLogin")
        break
        
    case .emailLogin, .emailSignup:
        break
    }

    return .empty
}
