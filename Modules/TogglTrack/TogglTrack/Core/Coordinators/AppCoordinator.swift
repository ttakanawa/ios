//
//  AppCoordinator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import RxSwift

public final class AppCoordinator: Coordinator
{
    public var route: AppRoute = .start
    
    public var rootViewController: UIViewController {
        return navigationController
    }
    
    private let window: UIWindow
    private var store: Store<AppState, AppAction>
    private var navigationController: UINavigationController
    
    private var disposeBag = DisposeBag()
    
    public init(window: UIWindow, store: Store<AppState, AppAction>)
    {
        self.window = window
        self.store = store
        navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
    }
    
    public func newRoute(route: String)
    {
        switch route {
        case "start":
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
