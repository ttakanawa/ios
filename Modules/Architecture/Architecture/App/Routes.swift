//
//  Routes.swift
//  Architecture
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation

public enum AppRoute
{
    case start
    case onboarding(OnboardingRoute)
    case mainTab
}

public enum OnboardingRoute
{
    case start
    case emailLogin
    case emailSignup
    case emailTos
    case loading
}
