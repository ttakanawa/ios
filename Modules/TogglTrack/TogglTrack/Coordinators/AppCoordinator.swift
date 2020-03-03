//
//  AppCoordinator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public final class AppCoordinator: Coordinator
{
    public var route: AppRoute = .start
    
    public var rootViewController: UIViewController {
        return navigationController
    }
    
    private var window: UIWindow
    private var navigationController: UINavigationController
        
    public init(window: UIWindow)
    {
        self.window = window
        navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
    }
    
    public func newRoute(route: String)
    {
        switch route {
        case "start":
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            break
        default:
            fatalError("Wrong path")
        }
    }
    
    public func finish(completion: (() -> Void)?)
    {
        fatalError("Should never complete")
    }
}
