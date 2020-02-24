//
//  BehaviorRelay+Extensions.swift
//  Utils
//
//  Created by Ricardo Sánchez Sotres on 22/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxCocoa

public extension BehaviorRelay
{
    var settableValue: Element
    {
        get {
            return value
        }
        set {
            accept(newValue)
        }
    }
}
