//
//  OnboardingCoordinator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

public final class OnboardingCoordinator: Coordinator
{    
    private var store: Store<OnboardingState, OnboardingAction>
    public var rootViewController: UIViewController!
    
    private var features: [String: BaseFeature<OnboardingState, OnboardingAction>]
    
    public init(store: Store<OnboardingState, OnboardingAction>, features: [String: BaseFeature<OnboardingState, OnboardingAction>])
    {
        self.store = store
        self.features = features
    }
    
    public func start(presentingViewController: UIViewController)
    {
        let vc = OnboardingViewController.instantiate()
        vc.store = store
        presentingViewController.show(vc, sender: nil)
        self.rootViewController = vc
    }
    
    public func newRoute(route: String) -> Coordinator?
    {
        guard let route = OnboardingRoute(rawValue: route) else { fatalError() }
        
        switch route {
        
        case .emailLogin:
            return features[route.rawValue]?.mainCoordinator(store: store)
        case .emailSignup:
            return features[route.rawValue]?.mainCoordinator(store: store)
        }
    }
    
    public func finish(completion: (() -> Void)? = nil)
    {
        completion?()
        //TODO FINISH CHILDREN
    }
}
