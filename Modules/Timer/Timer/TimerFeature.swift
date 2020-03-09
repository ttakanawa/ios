//
//  TimerFeature.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture

public let timerReducer = combine(
    timeEntriesLogReducer.pullback(
        state: \TimerState.timeLogState,
        action: \TimerAction.timeLog),
    startEditReducer.pullback(
        state: \TimerState.startEditState,
        action: \TimerAction.startEdit)
)

public class TimerFeature: BaseFeature<TimerState, TimerAction>
{
    let features: [String: BaseFeature<TimerState, TimerAction>] = [
        "log": TimeEntriesLogFeature()
            .view { $0.view(
                state: { $0.timeLogState },
                action: { TimerAction.timeLog($0) })
        },
        "startEdit": StartEditFeature()
            .view { $0.view(
                state: { $0.startEditState },
                action: { TimerAction.startEdit($0) })
        }
    ]
    
    public override func mainCoordinator(store: Store<TimerState, TimerAction>) -> Coordinator {
        return TimerCoordinator(
            store: store,
            timeLogCoordinator: features["log"]!.mainCoordinator(store: store) as! TimeEntriesLogCoordinator,
            startEditCoordinator: features["startEdit"]!.mainCoordinator(store: store) as! StartEditCoordinator
        )
    }
}
