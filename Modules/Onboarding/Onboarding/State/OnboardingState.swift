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

public struct LocalOnboardingState
{
    internal var email: String = ""
    internal var password: String = ""
    internal var loginButtonEnabled: Bool = false
    
    public init()
    {
    }
}

public struct OnboardingState
{
    public var user: Loadable<User>
    public private(set) var local: LocalOnboardingState
    
    public init(user: Loadable<User>, local: LocalOnboardingState)
    {
        self.user = user
        self.local = local
    }
    
    internal var email: String
    {
        get {
            local.email
        }
        set {
            local.email = newValue
        }
    }
    
    internal var password: String
    {
        get {
            local.password
        }
        set {
            local.password = newValue
        }
    }
    
    internal var loginButtonEnabled: Bool
    {
        get {
            local.loginButtonEnabled
        }
        set {
            local.loginButtonEnabled = newValue
        }
    }
}
