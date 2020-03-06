//
//  StartEditAction.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 28/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models

public enum StartEditAction
{
    case descriptionEntered(String)
    case startTapped
}


extension StartEditAction: CustomDebugStringConvertible
{
    public var debugDescription: String
    {
        switch self {
       
        case let .descriptionEntered(description):
            return "DescriptionEntered \(description)"
            
        case .startTapped:
            return "StartTapped"

        }
    }
}
