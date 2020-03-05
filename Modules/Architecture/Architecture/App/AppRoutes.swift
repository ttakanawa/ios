//
//  Routes.swift
//  Architecture
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation

public enum AppRoute: String
{
    case onboarding
    case loading
    case main
}

public enum OnboardingRoute: String
{
    case emailLogin
    case emailSignup
}

public enum EmailSignupRoute: String
{
    case tos
}

public enum TabBarRoute: String
{
    case timer
    case reports
    case calendar
}
