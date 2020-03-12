import Foundation
import RxCocoa

public extension BehaviorRelay {
    var settableValue: Element {
        get {
            return value
        }
        set {
            accept(newValue)
        }
    }
}
