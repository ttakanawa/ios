//
//  Coordinator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation

public protocol CoordinatorProtocol: AnyObject
{
    func finish(completion: (() -> Void)?)
    func navigate(to: String)
    func newRoute(route: String)
}

open class Coordinator: CoordinatorProtocol
{
    private let route: String
    private var currentRoute: String = ""
    public var child: Coordinator?
     
    public init(_ route: String)
    {
        self.route = route
    }
    
    final public func navigate(to path: String)
    {
        let components = path.split(separator: "/").map(String.init)
        if (components.penultimate == route) {
            if child != nil {
                child?.finish(completion: {
                    self.child = nil
                    self.newRouteIfNecessary(route: components.last!)
                })
            }
            
            newRouteIfNecessary(route: components.last!)
            
        } else {
            let subRoute = components.components(from: route)
            
            if child != nil {
                if child?.route == subRoute.first {
                    child?.navigate(to: subRoute.joined(separator: "/"))
                    return
                }
                
                child?.finish(completion: {
                    self.child = nil
                    self.navigate(to: path)
                })
                return
            }
            
            child = childForPath(subRoute.first!)
            child?.navigate(to: subRoute.joined(separator: "/"))
        }
    }
    
    private func newRouteIfNecessary(route: String)
    {
        guard currentRoute != route else {
            return
        }
        
        currentRoute = route
        newRoute(route: route)
    }
    
    open func finish(completion: (() -> Void)? = nil)
    {
        fatalError()
    }
    
    open func newRoute(route: String)
    {
        fatalError()
    }
    
    open func childForPath(_ path: String) -> Coordinator?
    {
        fatalError()
    }
}

extension Array where Element == String
{
    var penultimate: String?
    {
        if self.count < 2 {
            return nil
        }
        let index = self.count - 2
        return self[index]
    }
    
    func components(from: String) -> [String]
    {
        guard let index = self.firstIndex(of: from) else { return [] }
        return Array(self[index.advanced(by: 1)...])
    }
}
