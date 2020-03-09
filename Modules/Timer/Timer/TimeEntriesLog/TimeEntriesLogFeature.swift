//
//  TimeEntriesLogFeature.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture

class TimeEntriesLogFeature: BaseFeature<TimeEntriesLogState, TimeEntriesLogAction>
{
    override func mainCoordinator(store: Store<TimeEntriesLogState, TimeEntriesLogAction>) -> Coordinator {
        return TimeEntriesLogCoordinator(store: store)
    }
}

