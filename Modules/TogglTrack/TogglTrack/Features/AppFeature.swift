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

let appReducer = combine(
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

public class AppFeature: BaseFeature<AppState, AppAction>
{    
    let features: [String: BaseFeature<AppState, AppAction>] = [
        AppRoute.onboarding.rawValue: OnboardingFeature()
            .view { $0.view(
                    state: { $0.onboardingState },
                    action: { AppAction.onboarding($0) })
            },
        AppRoute.main.rawValue: TimerFeature()
        .view { $0.view(
                state: { $0.timerState },
                action: { AppAction.timer($0) })
        }
    ]
    
    public override func mainCoordinator(store: Store<AppState, AppAction>) -> Coordinator {
        return AppCoordinator(
            store: store,
            onboardingCoordinator: features[AppRoute.onboarding.rawValue]!.mainCoordinator(store: store),
            tabBarCoordinator: TabBarCoordinator(
                store: store,
                timerCoordinator: features[AppRoute.main.rawValue]!.mainCoordinator(store: store) as! TimerCoordinator
            )
        )
    }
}
