//
//  OnboardingState.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models
import Architecture
import Utils

public struct LocalOnboardingState
{
    internal var email: String = ""
    internal var password: String = ""
    
    public init()
    {
    }
}

public protocol OnboardingState
{
    var user: Loadable<User> { get set }
    var route: Route { get set }
    var localOnboardingState: LocalOnboardingState { get set }
}

extension OnboardingState
{
    internal var email: String
    {
        get {
            localOnboardingState.email
        }
        set {
            localOnboardingState.email = newValue
        }
    }
    
    internal var password: String
    {
        get {
            localOnboardingState.password
        }
        set {
            localOnboardingState.password = newValue
        }
    }
}
