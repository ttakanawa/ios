//
//  OnboardingAction.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation

public enum OnboardingAction
{
    case loginTapped(email: String, password: String)
    case forgotPasswordTapped
    case cancelTapped
    case goToSignupTapped
}
