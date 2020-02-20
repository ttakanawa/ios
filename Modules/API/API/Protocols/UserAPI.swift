//
//  UserAPI.swift
//  API
//
//  Created by Ricardo Sánchez Sotres on 20/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift
import Models

public protocol UserAPI
{
    func loginUser(email: String, password: String) -> Observable<User>
    func setAuth(token: String?)
}
