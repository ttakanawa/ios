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
import Environment

let _onboardingReducer = pullback(onboardingReducer,
                          state: \AppState.user,
                          action: \AppAction.onboarding,
                          environment: \AppEnvironment.api
)

let combinedReducers = combine(appReducer, _onboardingReducer)

func buildStore() -> Store<AppState, AppAction, AppEnvironment>
{
    return Store.create(
        initialState: AppState(),
        reducer: combinedReducers,
        environment: AppEnvironment(
            api: API()
        )
    )
}
