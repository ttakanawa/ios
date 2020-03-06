//
//  Router.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit

public final class Router
{
    private var stack: [(route: String, coordinator: Coordinator)]
    private var currentRoute: Route {
        return Route(components: stack.map({ $0.route }))
    }
     
    public init(initialRoute: String, initialCoordinator: Coordinator)
    {
        stack = [(route: initialRoute, coordinator: initialCoordinator)]
    }
    
    final public func navigate(to route: Route)
    {
        guard route != currentRoute else { return }
        print("Go to: \(route.path)")

        let toRemove: [Coordinator] = stack.enumerated().compactMap { i, element in
            guard i < route.components.count else { return element.coordinator }
            if route[i] == element.route { return nil }
            return element.coordinator
        }

        if toRemove.count > 0 {
            toRemove.last?.finish {
                self.stack.removeLast()
                self.navigate(to: route)
            }
            return
        }

        let toAdd = route.difference(with: currentRoute)
        if let component = toAdd.first
        {
            if let coordinator = self.stack.last!.coordinator.newRoute(route: component) {
                coordinator.present(from: stack.last!.coordinator.rootViewController)
                self.stack.append((route: component, coordinator: coordinator))
                self.navigate(to: route)
            }
        }
    }
}
