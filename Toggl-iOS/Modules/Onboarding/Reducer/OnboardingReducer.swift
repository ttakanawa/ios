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
        state.loginButtonEnabled = state.email.count > 5 && state.password.count > 5
                
    case let .passwordEntered(password):
        state.password = password
        state.loginButtonEnabled = state.email.count > 5 && state.password.count > 5
        
    case .loginTapped:
        state.user = .loading
        return loadUser(email: state.email, password: state.password, api: api)
        
    case let .setUser(user):
        guard let user = user else {
            state.user = .nothing
            break
        }
        state.user = .loaded(user)
        
    case .logoutTapped:
        break

    }
    
    return .empty
}

fileprivate func loadUser(email: String, password: String, api: API) -> Effect<OnboardingAction>
{
    return api.loginUser(email: email, password: password)
        .map({ OnboardingAction.setUser($0) })
        .catchError({ _ in Observable.just(OnboardingAction.logoutTapped) })
        .toEffect()
}
