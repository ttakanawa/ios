//
//  Routes.swift
//  Architecture
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation

public protocol Route
{
    var path: String { get }
}

public enum AppRoute: Route
{
    case start
    case onboarding(OnboardingRoute)
    case main(TabBarRoute)
    
    public var path: String
    {
        switch self {
        case .start:
            return "root/start"
        case let .onboarding(route):
            return "root/onboarding/\(route.path)"
        case let .main(route):
            return "root/main/\(route.path)"
        }
    }
}

public enum OnboardingRoute: Route
{
    case start
    case emailLogin(EmailLoginRoute)
    case emailSignup(EmailSignupRoute)
    case loading
    
    public var path: String
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

public enum EmailLoginRoute: Route
{
    case start
    
    public var path: String
    {
        switch self {
        case .start:
            return "start"
        }
    }
}

public enum EmailSignupRoute: Route
{
    case start
    case tos
    
    public var path: String
    {
        switch self {
        case .start:
            return "start"
        case .tos:
            return "tos"
        }
    }
}

public enum TabBarRoute: Route
{
    case timer
    case reports
    case calendar
    
    public var path: String
    {
        switch self {
        case .timer:
            return "timer"
        case .reports:
            return "reports"
        case .calendar:
            return "calendar"
        }
    }
}
