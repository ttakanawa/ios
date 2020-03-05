//
//  AppFeature.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 05/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture
import Onboarding
import Timer

let onboardingFeature: BaseFeature<AppState, AppAction, AppEnvironment> = OnboardingFeature()
    .wrap(
        pullback: { $0.pullback(
            state: \AppState.onboardingState,
            action: \AppAction.onboarding,
            environment: \AppEnvironment.userAPI
            )},
        viewStore: { $0.view(
            state: { $0.onboardingState },
            action: { AppAction.onboarding($0) }
            )}
)

public class AppFeature: BaseFeature<AppState, AppAction, AppEnvironment>
{    
    let features: [String: BaseFeature<AppState, AppAction, AppEnvironment>] = [
        AppRoute.onboarding.rawValue: onboardingFeature
    ]
    
    public override var reducer: Reducer<AppState, AppAction, AppEnvironment> {
        return combine(
            [globalReducer] + features.values.map{ $0.reducer } + [timeLogReducer.pullback(state: \AppState.timerState, action: \AppAction.timer, environment: \AppEnvironment.repository)]
        )
    }
    
    public override func mainCoordinator(store: Store<AppState, AppAction>) -> Coordinator {
        return AppCoordinator(store: store, features: features)
    }
}
