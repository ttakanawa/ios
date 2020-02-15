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
