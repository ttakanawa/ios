//
//  OnboardingReducer.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture
import Models

public typealias OnboardingState = (user: User?, showSignInModal: Bool)
public let onboardingReducer = Reducer<OnboardingState, OnboardingAction> { state, action in
    
    switch action {
       
    case .signInWithEmailTapped:
        state.showSignInModal = true
        
    case .loginTapped(let email, let password):
        print("Trying to login")
        
    case .forgotPasswordTapped:
        break
        
    case .cancelTapped:
        break
        
    case .goToSignupTapped:
        break
    }
    
    return .empty
}
