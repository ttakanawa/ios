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
import RxCocoa

public final class Store<State, Action>
{
    private var disposeBag: DisposeBag = DisposeBag()
    
    public var state: Driver<State>
    public var _dispatch: ((Action) -> Void)?
            
    private init(dispatch: @escaping (Action) -> Void, stateObservable: Driver<State>)
    {
        _dispatch = dispatch
        state = stateObservable
    }
    
    public init<Environment>(initialState: State, reducer: Reducer<State, Action, Environment>, environment: Environment)
    {
        let behaviorRelay = BehaviorRelay(value: initialState)
        state = behaviorRelay.asDriver()
        
        _dispatch = { action in
            let effect = reducer.reduce(&behaviorRelay.settableValue, action, environment)
            
            _ = effect
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: self.dispatch)
                .disposed(by: self.disposeBag)
        }
    }
    
    public func view<ViewState, ViewAction>(
        state toLocalState: @escaping (State) -> ViewState,
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

extension Store
{
    public func select<B>(_ selector: @escaping (State) -> B) -> Driver<B>
    {
        return state.map(selector)
    }
    
    public func select<B>(_ selector: @escaping (State) -> B) -> Driver<B> where B: Equatable
    {
        return state.map(selector).distinctUntilChanged()
    }
}
