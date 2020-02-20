//
//  TimeEntriesLogAction.swift
//  TimeEntriesLog
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models

public enum TimeEntriesLogAction
{
    case load
    
    case setEntities([TimeEntry])
    case setError(Error)
}
