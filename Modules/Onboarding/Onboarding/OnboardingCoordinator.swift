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
import Utils

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
        vc.store = store.view(
            state: { $0 },
            action: { .emailLogin($0) }
        )
        vc.coordinator = self
        let nav = UINavigationController(rootViewController: vc)
        if let presented = navigationController.presentedViewController {
            presented.dismiss(animated: true) {
                self.navigationController.present(nav, animated: true)
            }
        } else {
            navigationController.present(nav, animated: true)
        }
    }
    
    func showEmailSignUp()
    {
        let vc = SignupViewController.instantiate()
        vc.store = store.view(
            state: { $0 },
            action: { .emailSignup($0) }
        )
        vc.coordinator = self
        let nav = UINavigationController(rootViewController: vc)
        if let presented = navigationController.presentedViewController {
            presented.dismiss(animated: true) {
                self.navigationController.present(nav, animated: true)
            }
        } else {
            navigationController.present(nav, animated: true)
        }
    }
}
