//
//  OnboardingReducer.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture
import Models
import RxSwift
import API

public let onboardingReducer = Reducer<OnboardingState, OnboardingAction, API> { state, action, api in
    
    switch action {
        
    case let .emailEntered(email):
        state.email = email
                
    case let .passwordEntered(password):
        state.password = password
        
    case .loginTapped:
        state.user = .loading
        return loadUser(email: state.email, password: state.password, api: api)
        
    case let .setUser(user):
        state.user = .loaded(user)
        
    case let .setError(error):
        state.user = .error(error)
    }
    
    return .empty
}

fileprivate func loadUser(email: String, password: String, api: API) -> Effect<OnboardingAction>
{
    return api.loginUser(email: email, password: password)
        .map({ OnboardingAction.setUser($0) })
        .catchError({ Observable.just(OnboardingAction.setError($0)) })
        .toEffect()
}
