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

class ViewController: UIViewController {

    var store: Store<AppState, AppAction> = buildStore()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        let onboarding = OnboardingPresenter.mainView
        
        onboarding.store = store.view(
            state: { $0.user },
            action: { .onboarding($0) }
        )
        
        _ = store.state
            .map({ $0.user })
            .subscribe(onNext: { print($0) })
        
        UIApplication.shared.keyWindow?.rootViewController = onboarding
    }
}

