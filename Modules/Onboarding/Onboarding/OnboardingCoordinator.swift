//
//  OnboardingCoordinator.swift
//  UIExtensions
//
//  Created by Ricardo Sánchez Sotres on 17/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import Models
import API

public typealias OnboardingStore = Store<OnboardingState, OnboardingAction>

public class OnboardingCoordinator: Coordinator
{
    private let navigationController: UINavigationController
    private let store: OnboardingStore
    
    public var loggedIn: (() -> ())?
            
    public init(navigationController: UINavigationController, store: OnboardingStore)
    {
        self.navigationController = navigationController
        self.store = store
    }
    
    public func start()
    {
        let onboarding = OnboardingViewController.instantiate()
        onboarding.coordinator = self
        onboarding.store = store
        navigationController.pushViewController(onboarding, animated: true)
    }
 
    func showEmailSignIn()
    {
        let vc = LoginViewController.instantiate()
        vc.store = store
        vc.coordinator = self
        navigationController.present(vc, animated: true)
    }
}
