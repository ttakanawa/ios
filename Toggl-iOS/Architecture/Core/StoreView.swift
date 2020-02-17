//
//  StoreView.swift
//  Architecture
//
//  Created by Ricardo Sánchez Sotres on 17/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift

public typealias Store<State, Action, Environment> = StoreView<State, Action, Environment>

public class StoreView<State, Action, Environment>: StoreProtocol
{
    private let _dispatch: (Action) -> Void
    private let _state: Observable<State>
    private let _environment: Environment

    public convenience init<S: StoreProtocol>(_ store: S) where S.Action == Action, S.State == State, S.Environment == Environment {
        self.init(dispatch: store.dispatch, state: store.state, environment: store.environment)
    }

    public init(dispatch: @escaping (Action) -> Void, state: Observable<State>, environment: Environment) {
        self._dispatch = dispatch
        self._state = state
        self._environment = environment
    }

    public func dispatch(_ action: Action) {
        _dispatch(action)
    }

    public var state: Observable<State> {
        _state
    }
    
    public var environment: Environment {
        _environment
    }
    
    public static func create(initialState: State, reducer: Reducer<State, Action, Environment>, environment: Environment) -> StoreView
    {
        return StoreView(BaseStore(initialState: initialState, reducer: reducer, environment: environment))
    }
}
