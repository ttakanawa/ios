//
//  AppEnvironment.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 15/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Environment

public struct AppEnvironment
{
    public let api: API
    
    public init(api: API)
    {
        self.api = api
    }
}
