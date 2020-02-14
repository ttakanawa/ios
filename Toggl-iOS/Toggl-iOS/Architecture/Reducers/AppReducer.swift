//
//  AppReducer.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture

var appReducer: Reducer<AppState, AppAction> = Reducer { state, action in
    switch action
    {
    case .setBackgroundStatus:
        state.appStatus = .background
    case .setForegroundStatus:
        state.appStatus = .foreground
    case .onboarding:
        break
    }
    
    return .empty
}
