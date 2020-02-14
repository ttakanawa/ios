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

let _onboardingReducer = pullback(onboardingReducer,
                          state: \AppState.user,
                          action: \AppAction.onboarding)

let combinedReducers = combine(appReducer, _onboardingReducer)

func buildStore() -> Store<AppState, AppAction>
{
    return Store(BaseStore<AppState, AppAction>(
        initialState: AppState(),
        reducer: combinedReducers
    ))
}
