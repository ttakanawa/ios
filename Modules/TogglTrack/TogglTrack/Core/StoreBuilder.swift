//
//  StoreBuilder.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture
import Onboarding
import Timer
import API
import Repository

public func logging<State, Action, Environment>(
    _ reducer: Reducer<State, Action, Environment>
) -> Reducer<State, Action, Environment> {
    return Reducer { state, action, environment in
        print("Action: \(action)")
        return reducer.reduce(&state, action, environment)
    }
}

public func buildStore() -> Store<AppState, AppAction>
{
    let combinedReducers = combine(
        globalReducer,
        pullback(
            onboardingReducer,
            state: \AppState.onboardingState,
            action: \AppAction.onboarding,
            environment: \AppEnvironment.userAPI
        ),
        pullback(
            timerReducer,
            state: \AppState.timerState,
            action: \AppAction.timer,
            environment: \AppEnvironment.repository
        )
    )
    let appReducer = logging(combinedReducers)
    
    let api = API(urlSession: URLSession(configuration: URLSessionConfiguration.default))
    let repository = Repository(api: api)
    let appEnvironment = AppEnvironment(
        api: api,
        repository: repository
    )
    
    return Store(
        initialState: AppState(),
        reducer: appReducer,
        environment: appEnvironment
    )
}
