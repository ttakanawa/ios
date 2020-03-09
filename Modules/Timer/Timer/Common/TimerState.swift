//
//  TimerState.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models
import Utils

public struct LocalTimerState
{
    internal var description: String = ""
    
    public init()
    {
    }
}

public struct TimerState
{
    public var user: Loadable<User>
    public var entities: TimeLogEntities
    public var localTimerState: LocalTimerState
    
    public init(user: Loadable<User>, entities: TimeLogEntities, localTimerState: LocalTimerState) {
        self.user = user
        self.entities = entities
        self.localTimerState = localTimerState
    }
}

extension TimerState
{
    internal var timeLogState: TimeEntriesLogState
    {
        get {
            TimeEntriesLogState(entities: entities)
        }
        set {
            entities = newValue.entities
        }
    }
    
    internal var startEditState: StartEditState
    {
        get {
            StartEditState(
                user: user,
                entities: entities,
                description: localTimerState.description
            )
        }
        set {
            user = newValue.user
            entities = newValue.entities
            localTimerState.description = newValue.description
        }
    }
}
