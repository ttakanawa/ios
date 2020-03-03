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
    case finishedLoading
    
    case setEntities([Entity])
    case setError(Error)
}

extension TimerAction: CustomDebugStringConvertible
{
    public var debugDescription: String
    {
        switch self {
       
        case .load:
            return "Load"
            
        case .finishedLoading:
            return "FinishedLoading"
       
        case let .setEntities(entities):
            guard let first = entities.first else { return "SetEntities: 0" } // TODO Extract specific type from array
            return "SetEntities (\(type(of: first))): \(entities.count)"
        
        case let .setError(error):
            return "SetError: \(error)"
        
        }
    }
}
