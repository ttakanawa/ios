
//
//  EmailLoginAction.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models

public enum EmailLoginAction
{
    case goToSignup
    case cancel
    
    case emailEntered(String)
    case passwordEntered(String)
    case loginTapped
    
    case setUser(User)
    case setError(Error)
}
