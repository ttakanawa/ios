//
//  AppState.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models
import Architecture
import Onboarding
import TimeEntriesLog

enum AppStatus
{
    case unknown
    case foreground
    case background
}

public struct AppState
{
    var appStatus: AppStatus = .unknown
    var user: Loadable<User> = .nothing
    var entities: TimeLogEntities = TimeLogEntities()
    
    private var localOnboardingState: LocalOnboardingState = LocalOnboardingState()
}

// Module specific states
extension AppState
{
    var onboardingState: OnboardingState
    {
        get {
            return OnboardingState(user: user, local: localOnboardingState)
        }
        set {
            self.user = newValue.user
            self.localOnboardingState = newValue.local
        }
    }
    
    var timeEntriesLogState: TimeEntriesLogState
    {
        get {
            return TimeEntriesLogState(entities: entities)
        }
        set {
            self.entities = newValue.entities
        }
    }
}
