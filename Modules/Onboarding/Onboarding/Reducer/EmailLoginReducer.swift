//
//  EmailLoginReducer.swift
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

let emailLoginReducer = Reducer<OnboardingState, EmailLoginAction, UserAPI> { state, action, api in
    
    switch action {
    
    case .goToSignup:
        state.route = Route(path: "root/onboarding/emailSignup")
        break
    
    case .cancel:
        state.route = Route(path: "root/onboarding")
        break
    
    case let .emailEntered(email):
        state.email = email
        
    case let .passwordEntered(password):
        state.password = password
        
    case .loginTapped:
        state.user = .loading
        return loadUser(email: state.email, password: state.password, api: api)
        
    case let .setUser(user):
        state.user = .loaded(user)
        api.setAuth(token: user.apiToken)
        state.route = Route(path: "root/main")
        
    case let .setError(error):
        state.user = .error(error)
    }
    
    return .empty
}

fileprivate func loadUser(email: String, password: String, api: UserAPI) -> Effect<EmailLoginAction>
{
    return api.loginUser(email: email, password: password)
        .map({ EmailLoginAction.setUser($0) })
        .catchError({ Observable.just(EmailLoginAction.setError($0)) })
        .toEffect()
}
