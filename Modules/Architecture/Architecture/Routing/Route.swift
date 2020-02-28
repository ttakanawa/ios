//
//  Route.swift
//  Architecture
//
//  Created by Ricardo Sánchez Sotres on 27/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation

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
