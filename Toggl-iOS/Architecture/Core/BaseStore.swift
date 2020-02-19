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

public final class Store<State, Action>
{
    private var disposeBag: DisposeBag = DisposeBag()
    
    public var state: Observable<State>
    public var _dispatch: ((Action) -> Void)?
            
    private init(dispatch: @escaping (Action) -> Void, stateObservable: Observable<State>)
    {
        _dispatch = dispatch
        state = stateObservable
    }
    
    public init<Environment>(initialState: State, reducer: Reducer<State, Action, Environment>, environment: Environment)
    {
        let behaviorRelay = BehaviorRelay(value: initialState)
        state = behaviorRelay.asObservable()
        
        _dispatch = { action in
            let effect = reducer.reduce(&behaviorRelay.settableValue, action, environment)
            
            _ = effect
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: self.dispatch)
                .disposed(by: self.disposeBag)
        }
    }
    
    public func view<ViewState, ViewAction>(
        state toLocalState: @escaping (State) throws -> ViewState,
        action toGlobalAction: @escaping (ViewAction) -> Action?
    ) -> Store<ViewState, ViewAction>
    {
        return Store<ViewState, ViewAction>(
            dispatch: { action in
                guard let globalAction = toGlobalAction(action) else { return }
                self.dispatch(globalAction)
            },
            stateObservable: state.map(toLocalState)
        )
    }
        
    public func dispatch(_ action: Action)
    {
        // TODO Check or switch to Main Thread
        _dispatch?(action)
    }
}
