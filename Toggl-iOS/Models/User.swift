//
//  User.swift
//  Models
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation

public struct User: Codable, Equatable
{
    public var id: Int
    var apiToken: String

    enum CodingKeys: String, CodingKey
    {
        case id
    
        case apiToken = "api_token"
    }
}
