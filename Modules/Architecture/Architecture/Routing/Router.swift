//
//  Router.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit

public protocol RouterDelegate
{
    func coordinator(forRoute: String, rootViewController: UIViewController) -> Coordinator
}

public final class Router
{
    public var delegate: RouterDelegate?
    
    private var stack: [(route: Route, coordinator: Coordinator)]
    private var currentRoute: Route {
        return stack.last!.route
    }
     
    public init(initialCoordinator: Coordinator)
    {
        let route = Route(path: initialCoordinator.route.path)
        stack = [(route: route, coordinator: initialCoordinator)]
        initialCoordinator.newRoute(route: route.lastComponent)
    }
    
    final public func navigate(to appRoute: AppRoute)
    {
        let route = Route(path: appRoute.path)
        guard route != currentRoute else { return }
                
        if route.sameBase(as: currentRoute)
        {
            stack.last!.coordinator.newRoute(route: route.lastComponent)
            updateLast(route: route)
            return
        }
    
        let toRemove: [Coordinator] = stack.enumerated().compactMap { i, element in
            if route[i] == element.route.secondToLastComponent { return nil }
            return element.coordinator
        }

        if toRemove.count > 0 {
            remove(coordinators: toRemove) {
                self.navigate(to: appRoute)
            }
        }
                        
        let difference = route.difference(with: currentRoute).dropLast()
        for component in difference
        {
            guard let coordinator = self.coordinatorForPath(component) else { return }
            self.stack.append((route: Route(path: coordinator.route.path), coordinator: coordinator))
            let route = Route(path: coordinator.route.path)
            coordinator.newRoute(route: route.lastComponent)
        }
        
        updateLast(route: route)
    }
    
    private func remove(coordinators: [Coordinator], then: @escaping () -> ())
    {
        guard let lastToRemove = coordinators.last else {
            then()
            return
        }
        
        lastToRemove.finish {
            self.stack.removeLast()
            self.remove(coordinators: coordinators.dropLast(), then: then)
        }
    }
    
    private func coordinatorForPath(_ path: String) -> Coordinator?
    {
        let rootViewController = stack.last!.coordinator.rootViewController
        return delegate?.coordinator(forRoute: path, rootViewController: rootViewController)        
    }
    
    private func updateLast(route: Route)
    {
        let currentCoordinator = stack.last!.coordinator
        stack = stack.dropLast() + [(route: route, coordinator: currentCoordinator)]
    }
}
