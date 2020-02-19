//
//  Loadable.swift
//  Architecture
//
//  Created by Ricardo Sánchez Sotres on 15/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation

public enum Loadable<Value>
{
    case nothing
    case loading
    case error(Error)
    case loaded(Value)
}

public extension Loadable
{
    var isLoaded: Bool
    {
        switch self {
        case .loaded(_):
            return true
        default:
            return false
        }
    }
}

extension Loadable: CustomStringConvertible where Value: CustomStringConvertible
{
    public var description: String
    {
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
