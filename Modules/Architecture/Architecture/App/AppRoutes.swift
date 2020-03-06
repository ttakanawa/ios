//
//  Routes.swift
//  Architecture
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation

public enum AppRoute: String, Route
{
    public var root: Route? { nil }
    
    case loading
    case onboarding
    case main
}

public enum OnboardingRoute: String, Route
{
    public var root: Route? { AppRoute.onboarding }
    
    case emailLogin
    case emailSignup
}

public enum EmailSignupRoute: String, Route
{
    public var root: Route? { OnboardingRoute.emailSignup }
    
    case tos
}

public enum TabBarRoute: String, Route
{
    public var root: Route? { AppRoute.main }
    
    case timer
    case reports
    case calendar
}
