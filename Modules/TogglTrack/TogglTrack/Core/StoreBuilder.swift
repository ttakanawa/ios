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
import Networking

public func buildStore() -> Store<AppState, AppAction>
{
    let combinedReducers = combine(
        globalReducer,
        onboardingReducer.pullback(
            state: \AppState.onboardingState,
            action: \AppAction.onboarding,
            environment: \AppEnvironment.userAPI
        ),
        timerReducer.pullback(
            state: \AppState.timerState,
            action: \AppAction.timer,
            environment: \AppEnvironment.repository
        )
    )
    let appReducer = logging(combinedReducers)
    
//    let api = API(urlSession: URLSession(configuration: URLSessionConfiguration.default))
    let api = API(urlSession: FakeURLSession())
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
