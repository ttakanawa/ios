//
//  TimeEntriesLogState.swift
//  TimeEntriesLog
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models

public struct TimeEntriesLogState
{
    public var entities: TimeLogEntities
    //public private(set) var local: LocalTimeEntriesLogState

    public init(entities: TimeLogEntities)
    {
        self.entities = entities
    }
}
