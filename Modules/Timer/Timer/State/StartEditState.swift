//
//  StartEditState.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 03/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models
import Utils

public struct LocalStartEditState
{
    internal var description: String = ""
    
    public init()
    {
    }
}

public protocol StartEditState
{
    var user: Loadable<User> { get set }
    var entities: TimeLogEntities { get set }
    var localStartEditState: LocalStartEditState { get set }
}

extension StartEditState
{
    internal var description: String
    {
        get {
            localStartEditState.description
        }
        set {
            localStartEditState.description = newValue
        }
    }
}
