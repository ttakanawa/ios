//
//  TimerAction.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models

public enum TimerAction
{
    case load
    
    case setEntities([TimeEntry])
    case setError(Error)
}

extension TimerAction: CustomDebugStringConvertible
{
    public var debugDescription: String
    {
        switch self {
        case .load:
            return "Timer:Load"
        case let .setEntities(entities):
            return "SetEntities: \(entities.count)"
        case let .setError(error):
            return "SetError: \(error)"
        }
    }
}
