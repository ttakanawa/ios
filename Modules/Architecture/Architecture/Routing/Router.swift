import UIKit

public final class Router {
    private var stack: [(component: String, coordinator: Coordinator)]
    private var currentPath: String {
        return stack.map({ $0.component }).joined(separator: "/")
    }

    public init(initialCoordinator: Coordinator) {
        stack = [(component: "root", coordinator: initialCoordinator)]
    }

    final public func navigate(to route: String) {
        guard route != currentPath else { return }
        print("Go to: \(route)")

        let toRemove: [Coordinator] = stack.enumerated().compactMap { i, element in
            guard i < route.components.count else { return element.coordinator }
            if route[i] == element.component { return nil }
            return element.coordinator
        }

        if toRemove.count > 0 {
            toRemove.last?.finish {
                self.stack.removeLast()
                self.navigate(to: route)
            }
            return
        }

        let toAdd = route.difference(with: currentPath)
        if let component = toAdd.first {
            if let coordinator = self.stack.last!.coordinator.newRoute(route: component) {
                coordinator.present(from: stack.last!.coordinator.rootViewController)
                self.stack.append((component: component, coordinator: coordinator))
                self.navigate(to: route)
            }
        }
    }
}

typealias Path = String

extension Path {
    var components: [String] {
        return self.split(separator: "/").map(String.init)
    }

    subscript(index: Int) -> String {
        return components[index]
    }

    func difference(with otherPath: String) -> [String] {
        let pathComponents = otherPath.split(separator: "/")
        return components
            .enumerated()
            .compactMap { i, component in
                if i >= pathComponents.count { return component }
                return component == pathComponents[i]
                    ? nil
                    : component
            }
    }
}
