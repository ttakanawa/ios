//
//  TimeLogFeature.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture

class TimeLogFeature: BaseFeature<TimeLogState, TimeLogAction>
{
    override func mainCoordinator(store: Store<TimeLogState, TimeLogAction>) -> Coordinator {
        return TimeLogCoordinator(store: store)
    }
}

