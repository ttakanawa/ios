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

public protocol StoreType
{
    associatedtype State
    associatedtype Action
    
    var state: Observable<State> { get }
    func dispatch(_ action: Action)
}

public struct AnyStoreType<State, Action>: StoreType
{
    private let actionHandler: (Action) -> Void
    private let stateProvider: Observable<State>

    public init<S: StoreType>(_ store: S) where S.Action == Action, S.State == State {
        self.init(action: store.dispatch, state: store.state)
    }

    public init(action: @escaping (Action) -> Void, state: Observable<State>) {
        self.actionHandler = action
        self.stateProvider = state
    }

    public func dispatch(_ action: Action) {
        actionHandler(action)
    }

    public var state: Observable<State> {
        stateProvider
    }
}

public final class Store<State, Action>: StoreType
{
    private var reducer: Reducer<State, Action>
    private var disposeBag = DisposeBag()
    private var _state: BehaviorRelay<State>
    
    public var state: Observable<State> { _state.asObservable() }
    
    public init(initialState: State, reducer: Reducer<State, Action>)
    {
        _state = BehaviorRelay(value: initialState)
        self.reducer = reducer
    }
        
    public func dispatch(_ action: Action)
    {
        // TODO Check or switch to Main Thread
        
        let effect = reducer.reduce(&_state.settableValue, action)
        
        effect
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: dispatch)
            .disposed(by: disposeBag)
    }
}

extension StoreType
{
    public func view<LocalState, LocalAction>(
        state toLocalState: @escaping (State) -> LocalState,
        action toGlobalAction: @escaping (LocalAction) -> Action?
    ) -> AnyStoreType<LocalState, LocalAction>
    {
        return AnyStoreType(
            action: { newAction in
                guard let oldAction = toGlobalAction(newAction) else { return }
                self.dispatch(oldAction)
            },
            state: state.map(toLocalState)
        )
    }
}
