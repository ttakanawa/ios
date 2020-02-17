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
