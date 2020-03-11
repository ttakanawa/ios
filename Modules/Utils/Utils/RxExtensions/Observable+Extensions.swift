import Foundation
import RxSwift

extension ObservableConvertibleType
{
    public func mapTo<Result>(_ value: Result) -> Observable<Result>
    {
        return asObservable().map { _ in value }
    }
}
