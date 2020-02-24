//
//  AppCoordinator.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 17/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import Onboarding
import Timer
import Utils

public class AppCoordinator : Coordinator
{
    private let store: Store<AppState, AppAction>
    private let navigationController = UINavigationController()
    private let window: UIWindow
        
    public init(window: UIWindow, store: Store<AppState, AppAction>)
    {
        self.window = window
        self.store = store
    }
    
    public func start()
    {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
//        if userLoggedIn {
//
//        } else {
            showOnboarding()
//        }
    }
    
    private func showOnboarding()
    {
        let onboardingCoordinator = OnboardingCoordinator(
            navigationController: navigationController,
            store: store.view(
                state: { $0.onboardingState },
                action: { .onboarding($0) }
            )
        )
        onboardingCoordinator.loggedIn = {
            self.showTimeEntryLog()
        }
        onboardingCoordinator.start()
    }
    
    private func showTimeEntryLog()
    {
        let timeEntriesLog = TimerCoordinator(
            navigationController: navigationController,
            store: store.view(
                state: { $0.timerState },
                action: { .timer($0) }
            )
        )
        timeEntriesLog.start()
    }
}
