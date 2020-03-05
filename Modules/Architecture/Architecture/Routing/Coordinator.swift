//
//  Coordinator.swift
//  Architecture
//
//  Created by Ricardo Sánchez Sotres on 27/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit

public protocol Coordinator: AnyObject
{
    var rootViewController: UIViewController! { get }
    func start(presentingViewController: UIViewController)
    func finish(completion: (() -> Void)?)
    func newRoute(route: String) -> Coordinator?
}
