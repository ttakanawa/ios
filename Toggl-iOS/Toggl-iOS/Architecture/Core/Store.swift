//
//  Store.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 12/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import SwiftUI
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

open class Store<Action, State>
{
    private var reducer: Reducer<State, Action>
    private var disposeBag = DisposeBag()
    
    public var state: BehaviorRelay<State>
    
    init(initialState: State, reducer: Reducer<State, Action>)
    {
        state = BehaviorRelay(value: initialState)
        self.reducer = reducer
    }
        
    public func dispatch(_ action: Action)
    {
        // TODO Check or switch to Main Thread
        
        let effect = reducer.reduce(&state.settableValue, action)
        
        effect
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: dispatch)
            .disposed(by: disposeBag)
            
    }
    
    internal func newState(_ newState: State)
    {
        fatalError()
    }
}
