//
//  AppAction.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Onboarding
import TimeEntriesLog

public enum AppAction
{
    case setBackgroundStatus
    case setForegroundStatus
    
    case onboarding(OnboardingAction)
    case timeEntriesLog(TimeEntriesLogAction)
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
    
    var timeEntriesLog: TimeEntriesLogAction?
    {
        get {
            guard case let .timeEntriesLog(value) = self else { return nil }
            return value
        }
        set {
            guard case .timeEntriesLog = self, let newValue = newValue else { return }
            self = .timeEntriesLog(newValue)
        }
    }
}
