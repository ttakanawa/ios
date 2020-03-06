//
//  Route.swift
//  Architecture
//
//  Created by Ricardo Sánchez Sotres on 27/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

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
