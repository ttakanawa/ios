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
    
    public func map<B>(_ transform: @escaping (Action) throws -> B) -> Effect<B>
    {
        return Effect<B>(observable: observable.map(transform))
    }
    
    public static var empty: Effect<Action> { Effect(observable: Observable.empty()) }
    
    public static func from(effects: [Effect]) -> Effect
    {
        return Effect(observable: Observable.from(effects).merge())
    }
    
    public static func from(action: Action) -> Effect
    {
        return Effect(observable: Observable.just(action))
    }
    
    public func asObservable() -> Observable<Action>
    {
        return observable
    }
}

public extension ObservableConvertibleType
{
    func toEffect() -> Effect<Element>
    {
        return Effect(observable: self.asObservable())
    }
    
    func toEffect<Action>(
        map mapOutput: @escaping (Element) -> Action,
        catch catchErrors: @escaping (Error) -> Action
    ) -> Effect<Action>
    {
        return self.asObservable()
            .map(mapOutput)
            .catchError{ Observable<Action>.just(catchErrors($0)) }
            .toEffect()
    }
}
