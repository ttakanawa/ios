//
//  Observable+Extensions.swift
//  Utils
//
//  Created by Ricardo Sánchez Sotres on 22/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableConvertibleType
{
    public func mapTo<Result>(_ value: Result) -> Observable<Result>
    {
        return asObservable().map { _ in value }
    }
}
