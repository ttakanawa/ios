//
//  Coordinator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import RxSwift
import Architecture

public protocol Coordinator: AnyObject
{
    var route: AppRoute { get }
    var rootViewController: UIViewController { get }
    func finish(completion: (() -> Void)?)
    func newRoute(route: String)
}

public protocol RouterDelegate
{
    func coordinator(forRoute: String, rootViewController: UIViewController) -> Coordinator
}

public final class Router
{
    public var delegate: RouterDelegate?
    
    private var stack: [(route: Route, coordinator: Coordinator)]
    private var disposeBag = DisposeBag()
    private var currentRoute: Route {
        return stack.last!.route
    }
     
    public init(initialCoordinator: Coordinator)
    {
        stack = [(route: Route(path: initialCoordinator.route.path), coordinator: initialCoordinator)]
    }
    
    final public func navigate(to appRoute: AppRoute)
    {
        let route = Route(path: appRoute.path)
        navigate(to: route)
    }
        
    private func navigate(to route: Route)
    {
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
                self.navigate(to: route)
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

struct Route: Equatable
{
    let path: String
    let components: [String]
    
    init(path: String)
    {
        self.path = path
        components = path.split(separator: "/").map(String.init)
    }
    
    init(components: [String])
    {
        path = components.joined(separator: "/")
        self.components = components
    }
    
    public func sameBase(as otherRoute: Route) -> Bool
    {
        return components.dropLast() == otherRoute.components.dropLast()
    }
    
    public func difference(with otherRoute: Route) -> [String]
    {
        return components
            .enumerated()
            .compactMap { i, component in
                if i >= otherRoute.components.count { return component }
                return component == otherRoute[i]
                    ? nil
                    : component
            }
    }
    
    public var lastComponent: String
    {
        return components.last!
    }
    
    public var secondToLastComponent: String
    {
        return components[components.count - 2]
    }
    
    subscript(index: Int) -> String
    {
        return components[index]
    }
}
