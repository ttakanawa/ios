//
//  EmailSignupReducer.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture
import Models
import RxSwift
import API

let emailSignupReducer = Reducer<OnboardingState, EmailSignupAction, UserAPI> { state, action, api in
    
    switch action {
    
    case .goToLogin:
        state.route = OnboardingRoute.emailLogin
        break
    
    case .cancel:
        state.route = AppRoute.onboarding
        break
    
    case let .emailEntered(email):
        state.email = email
        
    case let .passwordEntered(password):
        state.password = password
        
    case .signupTapped:
        state.user = .loading
        return signupUser(email: state.email, password: state.password, api: api)

    case let .setUser(user):
        state.user = .loaded(user)
        api.setAuth(token: user.apiToken)
        
    case let .setError(error):
        state.user = .error(error)
    }
    
    return .empty
}

fileprivate func signupUser(email: String, password: String, api: UserAPI) -> Effect<EmailSignupAction>
{
    return .empty
}
