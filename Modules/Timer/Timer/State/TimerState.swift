//
//  TimerState.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models

public struct LocalTimerState
{
    internal var description: String = ""
    
    public init()
    {
    }
}

public protocol TimerState
{
    var entities: TimeLogEntities { get set }
    var localTimerState: LocalTimerState { get set }
}

extension TimerState
{
    internal var description: String
    {
        get {
            localTimerState.description
        }
        set {
            localTimerState.description = newValue
        }
    }
}
