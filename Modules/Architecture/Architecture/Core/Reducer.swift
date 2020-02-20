//
//  Reducer.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 12/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift

public typealias ReduceFunction<StateType, ActionType, Environment> = (inout StateType, ActionType, Environment) -> Effect<ActionType>

public struct Reducer<StateType, ActionType, Environment>
{
    public let reduce: ReduceFunction<StateType, ActionType, Environment>
    
    public init(_ reduce: @escaping ReduceFunction<StateType, ActionType, Environment>)
    {
        self.reduce = reduce
    }
}

public func combine<State, Action, Environment>(
    _ reducers: Reducer<State, Action, Environment>...
) -> Reducer<State, Action, Environment> {
    return Reducer { state, action, environment in
        let effects = reducers.map{ $0.reduce(&state, action, environment)}
        return Effect.from(effects: effects)
    }
}

public func pullback<LocalState, GlobalState, LocalAction, GlobalAction, LocalEnvironment, GlobalEnvironment>(
    _ reducer: Reducer<LocalState, LocalAction, LocalEnvironment>,
    state: WritableKeyPath<GlobalState, LocalState>,
    action: WritableKeyPath<GlobalAction, LocalAction?>,
    environment: KeyPath<GlobalEnvironment, LocalEnvironment>
) -> Reducer<GlobalState, GlobalAction, GlobalEnvironment> {
    return Reducer { globalState, globalAction, globalEnvironment in
        guard let localAction = globalAction[keyPath: action] else { return .empty }
        let localEnvironment = globalEnvironment[keyPath: environment]
        return reducer
            .reduce(&globalState[keyPath: state], localAction, localEnvironment)
            .map { localAction -> GlobalAction in
              var globalAction = globalAction
              globalAction[keyPath: action] = localAction
              return globalAction
            }
    }
}
