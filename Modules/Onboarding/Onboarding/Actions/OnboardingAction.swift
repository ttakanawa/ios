//
//  OnboardingAction.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models

public enum OnboardingAction
{
    case emailSingInTapped    
    case emailLogin(EmailLoginAction)
    case emailSignup(EmailSignupAction)
}


extension OnboardingAction
{
    var emailLogin: EmailLoginAction? {
        get {
            guard case let .emailLogin(value) = self else { return nil }
            return value
        }
        set {
            guard case .emailLogin = self, let newValue = newValue else { return }
            self = .emailLogin(newValue)
        }
    }
    
    var emailSignup: EmailSignupAction?
    {
        get {
            guard case let .emailSignup(value) = self else { return nil }
            return value
        }
        set {
            guard case .emailSignup = self, let newValue = newValue else { return }
            self = .emailSignup(newValue)
        }
    }
}
