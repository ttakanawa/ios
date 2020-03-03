//
//  TimerState.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models
import Utils

public protocol TimerState
{
    var entities: TimeLogEntities { get set }
}
