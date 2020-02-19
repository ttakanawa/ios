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
import API

let _onboardingReducer = pullback(onboardingReducer,
                          state: \AppState.onboardingState,
                          action: \AppAction.onboarding,
                          environment: \AppEnvironment.api
)

let combinedReducers = combine(appReducer, _onboardingReducer)

public func buildStore() -> Store<AppState, AppAction>
{
    return Store(
        initialState: AppState(),
        reducer: combinedReducers,
        environment: AppEnvironment(
            api: API(urlSession: URLSession(configuration: URLSessionConfiguration.default))
        )
    )
}
