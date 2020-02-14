//
//  Reducer.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 12/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift

public typealias ReduceFunction<StateType, ActionType> = (inout StateType, ActionType) -> Effect<ActionType>

public struct Reducer<StateType, ActionType>
{
    let reduce: ReduceFunction<StateType, ActionType>
    
    public init(_ reduce: @escaping ReduceFunction<StateType, ActionType>)
    {
        self.reduce = reduce
    }
}

public func combine<State, Action>(
    _ reducers: Reducer<State, Action>...
) -> Reducer<State, Action> {
    return Reducer { state, action in
        let effects = reducers.map{ $0.reduce(&state, action)}
        return Effect.from(effects: effects)
    }
}

public func pullback<LocalState, GlobalState, LocalAction, GlobalAction>(
    _ reducer: Reducer<LocalState, LocalAction>,
    state: WritableKeyPath<GlobalState, LocalState>,
    action: WritableKeyPath<GlobalAction, LocalAction?>
) -> Reducer<GlobalState, GlobalAction> {
    return Reducer { globalState, globalAction in
        guard let localAction = globalAction[keyPath: action] else { return .empty }
        return reducer
            .reduce(&globalState[keyPath: state], localAction)
            .map { localAction -> GlobalAction in
              var globalAction = globalAction
              globalAction[keyPath: action] = localAction
              return globalAction
            }
    }
}
