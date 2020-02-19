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

public struct OnboardingState
{
    public var user: Loadable<User>
    internal var email: String = ""
    internal var password: String = ""
    internal var loginButtonEnabled: Bool = false
    
    public init()
    {
        user = .nothing
    }
}
