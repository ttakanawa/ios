//
//  Store.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 12/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

extension BehaviorRelay
{
    var settableValue: Element {
        set {
            accept(newValue)
        }
        get {
            return value
        }
    }
}

public protocol StoreProtocol
{
    associatedtype State
    associatedtype Action
    associatedtype Environment
    
    var state: Observable<State> { get }
    var environment: Environment { get }
    func dispatch(_ action: Action)
}

public struct Store<State, Action, Environment>: StoreProtocol
{
    private let actionHandler: (Action) -> Void
    private let stateProvider: Observable<State>
    private let _environment: Environment

    public init<S: StoreProtocol>(_ store: S) where S.Action == Action, S.State == State, S.Environment == Environment {
        self.init(action: store.dispatch, state: store.state, environment: store.environment)
    }

    public init(action: @escaping (Action) -> Void, state: Observable<State>, environment: Environment) {
        self.actionHandler = action
        self.stateProvider = state
        self._environment = environment
    }

    public func dispatch(_ action: Action) {
        actionHandler(action)
    }

    public var state: Observable<State> {
        stateProvider
    }
    
    public var environment: Environment {
        _environment
    }
    
    public static func create(initialState: State, reducer: Reducer<State, Action, Environment>, environment: Environment) -> Store
    {
        return Store(BaseStore(initialState: initialState, reducer: reducer, environment: environment))
    }
}

public final class BaseStore<State, Action, Environment>: StoreProtocol
{
    private var reducer: Reducer<State, Action, Environment>
    private var disposeBag = DisposeBag()
    private var _state: BehaviorRelay<State>
    
    public let environment: Environment
    public var state: Observable<State> { _state.asObservable() }
    
    public init(initialState: State, reducer: Reducer<State, Action, Environment>, environment: Environment)
    {
        _state = BehaviorRelay(value: initialState)
        self.reducer = reducer
        self.environment = environment
    }
        
    public func dispatch(_ action: Action)
    {
        // TODO Check or switch to Main Thread
        
        let effect = reducer.reduce(&_state.settableValue, action, environment)
        
        effect
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: dispatch)
            .disposed(by: disposeBag)
    }
}

extension StoreProtocol
{
    public func view<LocalState, LocalAction, S: StoreProtocol, LocalEnvironment>(
        state toLocalState: @escaping (State) -> LocalState,
        action toGlobalAction: @escaping (LocalAction) -> Action?,
        environment toLocalEnvironment: @escaping (Environment) -> LocalEnvironment
    ) -> S where S.State == LocalState, S.Action == LocalAction
    {
        return Store<LocalState, LocalAction, LocalEnvironment>(
            action: { newAction in
                guard let oldAction = toGlobalAction(newAction) else { return }
                self.dispatch(oldAction)
            },
            state: state.map(toLocalState),
            environment: toLocalEnvironment(environment)
        ) as! S
    }
}
