//
//  BehaviorRelay+Extensions.swift
//  Common
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

public extension BehaviorRelay
{
    var settableValue: Element {
        set {
            accept(newValue)
        }
        get {
            return value
        }
    }
}
