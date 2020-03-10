import Foundation
import Architecture

public func logging<State, Action, Environment>(
    _ reducer: Reducer<State, Action, Environment>
) -> Reducer<State, Action, Environment> {
    return Reducer { state, action, environment in
        print("Action: \(action)")
        return reducer.reduce(&state, action, environment)
    }
}
