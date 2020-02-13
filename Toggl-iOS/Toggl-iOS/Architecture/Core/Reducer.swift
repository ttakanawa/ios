//
//  Reducer.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 12/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation

public typealias ReduceFunction<StateType, ActionType> = (inout StateType, ActionType) -> Effect<ActionType>

public struct Reducer<StateType, ActionType>
{
    public let reduce: ReduceFunction<StateType, ActionType>
    
    public init(_ reduce: @escaping ReduceFunction<StateType, ActionType>)
    {
        self.reduce = reduce
    }
}
