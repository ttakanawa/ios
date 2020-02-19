//
//  ObservableType+Extensions.swift
//  Common
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift

public extension ObservableType
{
    func mapTo<Result>(_ value: Result) -> Observable<Result>
    {
        return map { _ in value }
    }
}
