//
//  StoreProtocol.swift
//  Architecture
//
//  Created by Ricardo Sánchez Sotres on 17/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift

public protocol StoreProtocol
{
    associatedtype State
    associatedtype Action
    associatedtype Environment
    
    var state: Observable<State> { get }
    var environment: Environment { get }
    func dispatch(_ action: Action)
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
            dispatch: { newAction in
                guard let oldAction = toGlobalAction(newAction) else { return }
                self.dispatch(oldAction)
            },
            state: state.map(toLocalState),
            environment: toLocalEnvironment(environment)
        ) as! S
    }
}
