//
//  StoreBuilder.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture

func buildStore() -> AnyStoreType<AppState, AppAction>
{
    return AnyStoreType(Store<AppState, AppAction>(
        initialState: AppState(),
        reducer: appReducer
    ))
}
