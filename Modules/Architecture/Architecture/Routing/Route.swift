import Foundation

public protocol Route
{
    var path: String { get }
    var root: Route? { get }
}

public extension Route where Self: RawRepresentable, Self.RawValue == String
{
    var path: String
    {
        return "\(root?.path ?? "root")/\(self.rawValue)"
    }
}
