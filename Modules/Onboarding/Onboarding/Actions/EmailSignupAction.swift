//
//  EmailSignupAction.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models

public enum EmailSignupAction
{
    case goToLogin
    case cancel
    
    case emailEntered(String)
    case passwordEntered(String)
    case signupTapped
    
    case setUser(User)
    case setError(Error)
}
