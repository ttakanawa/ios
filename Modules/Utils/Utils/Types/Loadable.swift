import Foundation

public enum Loadable<Value> {
    case nothing
    case loading
    case error(Error)
    case loaded(Value)
}

public extension Loadable {
    var isLoaded: Bool {
        switch self {
        case .loaded:
            return true
        default:
            return false
        }
    }

    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }

    var value: Value? {
        switch self {
        case let .loaded(value):
            return value
        default:
            return nil
        }
    }
}

extension Loadable: CustomStringConvertible where Value: CustomStringConvertible {
    public var description: String {
        switch self {
            case .nothing:
                return "empty"
            case .loading:
                return "loading"
            case let .error(error):
                return "error: \(error)"
            case let .loaded(value):
                return "loaded: \(value)"
        }
    }
}
