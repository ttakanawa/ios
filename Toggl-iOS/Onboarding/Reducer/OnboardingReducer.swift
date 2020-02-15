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
import Environment

public let onboardingReducer = Reducer<Loadable<User>, OnboardingAction, API> { state, action, api in
    
    switch action {
       
    case .loginTapped(let email, let password):
        state = .loading
        return loadUser(email: email, password: password)
        
    case let .setUser(user):
        guard let user = user else {
            state = .nothing
            break
        }
        state = .loaded(user)
        
    case .logoutTapped:
        break

    }
    
    return .empty
}

fileprivate func loadUser(email: String, password: String) -> Effect<OnboardingAction>
{
    return Observable
        .just(OnboardingAction.setUser(User(email: email)))
        .delay(.seconds(1), scheduler: MainScheduler.instance)
        .toEffect()
}
