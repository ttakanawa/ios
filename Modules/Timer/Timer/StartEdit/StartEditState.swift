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

public struct StartEditState
{
    var user: Loadable<User>
    var entities: TimeLogEntities
    var description: String
}
