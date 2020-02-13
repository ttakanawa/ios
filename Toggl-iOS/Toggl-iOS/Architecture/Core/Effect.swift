//
//  Effect.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 12/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift

public struct Effect<Action>: ObservableType
{
    public typealias Element = Action
    
    let observable: Observable<Action>
    
    fileprivate init(observable: Observable<Action>)
    {
        self.observable = observable
    }
        
    public func subscribe<Observer>(_ observer: Observer) -> Disposable where Observer : ObserverType, Element == Observer.Element
    {
        observable.subscribe(observer)
    }
    
    public static var empty: Effect<Action> { Effect(observable: Observable.empty()) }
}
