//
//  AppAction.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Onboarding
import Timer

public enum AppAction
{
    case setBackgroundStatus
    case setForegroundStatus
    case start
    
    case tabBarTapped(Int)
    
    case onboarding(OnboardingAction)
    case timer(TimerAction)
}

extension AppAction
{
    var onboarding: OnboardingAction? {
        get {
            guard case let .onboarding(value) = self else { return nil }
            return value
        }
        set {
            guard case .onboarding = self, let newValue = newValue else { return }
            self = .onboarding(newValue)
        }
    }
    
    var timer: TimerAction?
    {
        get {
            guard case let .timer(value) = self else { return nil }
            return value
        }
        set {
            guard case .timer = self, let newValue = newValue else { return }
            self = .timer(newValue)
        }
    }
}
