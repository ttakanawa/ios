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
    public var rootViewController: UIViewController!
    
    private var store: Store<AppState, AppAction>
    private var navigationController: UINavigationController!
    private var features: [String: BaseFeature<AppState, AppAction>]
        
    public init(store: Store<AppState, AppAction>, features: [String: BaseFeature<AppState, AppAction>])
    {
        self.store = store
        self.features = features
    }
    
    public func start(window: UIWindow)
    {
        self.navigationController = UINavigationController()
        navigationController.view.backgroundColor = .purple
        rootViewController = navigationController
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()        
    }
    
    public func start(presentingViewController: UIViewController)
    {
        fatalError("user start(window:) for the main coordinator")
    }
    
    public func newRoute(route: String) -> Coordinator?
    {
        guard let route = AppRoute(rawValue: route) else { fatalError() }
        
        switch route {
        
        case .onboarding:
            return features[route.rawValue]!.mainCoordinator(store: store)
            
        case .loading:
            let vc = LoadingViewController()
            vc.view.backgroundColor = .red
            vc.store = store
            rootViewController.show(vc, sender: nil)
            return nil
            
        case .main:
            return features[route.rawValue]!.mainCoordinator(store: store)
            
        }
    }
    
    public func finish(completion: (() -> Void)?)
    {
        fatalError("Should never complete")
    }
}

class LoadingViewController: UIViewController
{
    public var store: Store<AppState, AppAction>!
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
}
