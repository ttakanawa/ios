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
import Timer

enum AppStatus
{
    case unknown
    case foreground
    case background
}

public struct AppState
{
    var appStatus: AppStatus = .unknown
    public var user: Loadable<User> = .nothing
    public var entities: TimeLogEntities = TimeLogEntities()
    
    public var localOnboardingState: LocalOnboardingState = LocalOnboardingState()
}

// Module specific states
extension AppState: OnboardingState
{
    var onboardingState: OnboardingState
    {
        get {
            self
        }
        set {
            user = newValue.user
            localOnboardingState = newValue.localOnboardingState
        }
    }
}

extension AppState: TimerState
{
    var timerState: TimerState
    {
        get {
            self
        }
        set {
            entities = newValue.entities
        }
    }
}
