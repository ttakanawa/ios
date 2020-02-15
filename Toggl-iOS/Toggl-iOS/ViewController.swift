//
//  ViewController.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 12/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import Onboarding
import Environment

class ViewController: UIViewController {
    
    var store: Store<AppState, AppAction, AppEnvironment>!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        let onboarding = OnboardingPresenter.mainView
        
        onboarding.store = store.view(
            state: { $0.user },
            action: { .onboarding($0) },
            environment: { $0.api }
        )
        
        UIApplication.shared.keyWindow?.rootViewController = onboarding
    }
}

