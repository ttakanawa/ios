import Foundation
import RxSwift
import RxRelay
import RxCocoa
import Utils

public final class Store<State, Action> {
    private var disposeBag: DisposeBag = DisposeBag()

    public var state: Driver<State>
    public var _dispatch: (([Action]) -> Void)?

    private init(dispatch: @escaping ([Action]) -> Void, stateObservable: Driver<State>) {
        _dispatch = dispatch
        state = stateObservable
    }

    public init<Environment>(initialState: State, reducer: Reducer<State, Action, Environment>, environment: Environment) {
        let behaviorRelay = BehaviorRelay(value: initialState)
        state = behaviorRelay.asDriver()

        _dispatch = { actions in
            var tempState = behaviorRelay.value
            var effects = [Effect<Action>]()
            for action in actions {
                let effect = reducer.reduce(&tempState, action, environment)
                effects.append(effect)
            }

            behaviorRelay.accept(tempState)

            _ = Observable.concat(effects.map { $0.asObservable() })
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: self.dispatch)
                .disposed(by: self.disposeBag)
        }
    }

    public func view<ViewState, ViewAction>(
        state toLocalState: @escaping (State) -> ViewState,
        action toGlobalAction: @escaping (ViewAction) -> Action?
    ) -> Store<ViewState, ViewAction> {
        return Store<ViewState, ViewAction>(
            dispatch: { actions in
                self.batch(
                    actions.compactMap(toGlobalAction)
                )
            },
            stateObservable: state.map(toLocalState)
        )
    }

    public func dispatch(_ action: Action) {
        DispatchQueue.main.async { [weak self] in
            self?._dispatch?([action])
        }
    }

    public func batch(_ actions: [Action]) {
        DispatchQueue.main.async { [weak self] in
            self?._dispatch?(actions)
        }
    }

}

extension Store {
    public func select<B>(_ selector: @escaping (State) -> B) -> Driver<B> {
        return state.map(selector)
    }

    public func select<B>(_ selector: @escaping (State) -> B) -> Driver<B> where B: Equatable {
        return state.map(selector).distinctUntilChanged()
    }
}
