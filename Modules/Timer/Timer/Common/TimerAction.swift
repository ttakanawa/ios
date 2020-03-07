//
//  TimerAction.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models

public enum TimerAction
{
    case timeLog(TimeLogAction)
    case startEdit(StartEditAction)
}

extension TimerAction
{
    var timeLog: TimeLogAction? {
        get {
            guard case let .timeLog(value) = self else { return nil }
            return value
        }
        set {
            guard case .timeLog = self, let newValue = newValue else { return }
            self = .timeLog(newValue)
        }
    }
    
    var startEdit: StartEditAction?
    {
        get {
            guard case let .startEdit(value) = self else { return nil }
            return value
        }
        set {
            guard case .startEdit = self, let newValue = newValue else { return }
            self = .startEdit(newValue)
        }
    }
}


extension TimerAction: CustomDebugStringConvertible
{
    public var debugDescription: String
    {
        switch self {
       
        case let .timeLog(action):
            return action.debugDescription
            
        case let .startEdit(action):
            return action.debugDescription               
        
        }
    }
}
