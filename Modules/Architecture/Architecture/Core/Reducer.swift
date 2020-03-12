import Foundation
import RxSwift

public typealias ReduceFunction<StateType, ActionType, EnvironmentType> = (inout StateType, ActionType, EnvironmentType) -> Effect<ActionType>

public struct Reducer<StateType, ActionType, EnvironmentType> {
    public let reduce: ReduceFunction<StateType, ActionType, EnvironmentType>
    
    public init(_ reduce: @escaping ReduceFunction<StateType, ActionType, EnvironmentType>) {
        self.reduce = reduce
    }
    
    public func pullback<GlobalState, GlobalAction, GlobalEnvironment>(
        state: WritableKeyPath<GlobalState, StateType>,
        action: WritableKeyPath<GlobalAction, ActionType?>,
        environment: KeyPath<GlobalEnvironment, EnvironmentType>
    ) -> Reducer<GlobalState, GlobalAction, GlobalEnvironment> {
        return Reducer<GlobalState, GlobalAction, GlobalEnvironment> { globalState, globalAction, globalEnvironment in
            guard let localAction = globalAction[keyPath: action] else { return .empty }
            let localEnvironment = globalEnvironment[keyPath: environment]
            return self
                .reduce(&globalState[keyPath: state], localAction, localEnvironment)
                .map { localAction -> GlobalAction in
                  var globalAction = globalAction
                  globalAction[keyPath: action] = localAction
                  return globalAction
                }
        }
    }
    
    public func pullback<GlobalAction, GlobalEnvironment>(
        action: WritableKeyPath<GlobalAction, ActionType?>,
        environment: KeyPath<GlobalEnvironment, EnvironmentType>
    ) -> Reducer<StateType, GlobalAction, GlobalEnvironment> {
        return self.pullback(state: \StateType.self, action: action, environment: environment)
    }
    
    public func pullback<GlobalState, GlobalAction>(
        state: WritableKeyPath<GlobalState, StateType>,
        action: WritableKeyPath<GlobalAction, ActionType?>
    ) -> Reducer<GlobalState, GlobalAction, EnvironmentType> {
        return self.pullback(state: state, action: action, environment: \EnvironmentType.self)
    }
    
    public func pullback<GlobalAction>(
        action: WritableKeyPath<GlobalAction, ActionType?>
    ) -> Reducer<StateType, GlobalAction, EnvironmentType> {
        return self.pullback(state: \StateType.self, action: action, environment: \EnvironmentType.self)
    }
}

public func combine<State, Action, Environment>(
    _ reducers: Reducer<State, Action, Environment>...
) -> Reducer<State, Action, Environment> {
    combine(reducers)
}

public func combine<State, Action, Environment>(
    _ reducers: [Reducer<State, Action, Environment>]
) -> Reducer<State, Action, Environment> {
    return Reducer { state, action, environment in
        let effects = reducers.map { $0.reduce(&state, action, environment) }
        return Effect.from(effects: effects)
    }
}
