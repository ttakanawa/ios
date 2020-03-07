//
//  AppReducer.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture
import Timer

var globalReducer: Reducer<AppState, AppAction, AppEnvironment> = Reducer { state, action, environment in
    switch action
    {
    case .setBackgroundStatus:
        state.appStatus = .background
        return .empty
        
    case .setForegroundStatus:
        state.appStatus = .foreground
        return .empty
        
    case .start:
        if state.user.isLoaded {
            state.route = AppRoute.main
        } else {
            state.route = AppRoute.onboarding
        }
        return .empty
        
    case let .tabBarTapped(section):
        state.route = [
            TabBarRoute.timer,
            TabBarRoute.reports,
            TabBarRoute.calendar
        ][section]
        return .empty
        
    case .onboarding, .timer, .startEdit:
        return .empty
    }
}
