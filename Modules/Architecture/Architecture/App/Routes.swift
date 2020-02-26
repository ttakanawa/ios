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
    case onboarding(OnboardingRoute)
    case mainTab
    
    public var path: String
    {
        switch self {
        case let .onboarding(route):
            return "root/onboarding/\(route)"
        case .mainTab:
            return "root/mainTab"
        }
    }
}

public enum OnboardingRoute
{
    case start
    case emailLogin(EmailLoginRoute)
    case emailSignup(EmailSignupRoute)
    case loading
    
    var path: String
    {
        switch self {
        case .start:
            return "start"
        case let .emailLogin(route):
            return "emailLogin/\(route)"
        case let .emailSignup(route):
            return "emailSignup/\(route)"
        case .loading:
            return "loading"
        }
    }
}

public enum EmailLoginRoute
{
    case start
    
    var path: String
    {
        switch self {
        case .start:
            return "start"
        }
    }
}

public enum EmailSignupRoute
{
    case start
    case tos
    
    var path: String
    {
        switch self {
        case .start:
            return "start"
        case .tos:
            return "tos"
        }
    }
}

