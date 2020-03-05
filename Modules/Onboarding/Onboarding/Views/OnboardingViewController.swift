//
//  OnboardingViewController.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 14/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import Models
import RxCocoa
import RxSwift
import API
import Utils
import Assets

public typealias OnboardingStore = Store<OnboardingState, OnboardingAction>

public class OnboardingViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Onboarding"
    public static var storyboardBundle = Assets.bundle
    
    @IBOutlet weak var emailSignInButton: UIButton!

    private var disposeBag = DisposeBag()
    
    public var store: OnboardingStore!

    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        emailSignInButton.rx.tap
            .mapTo(OnboardingAction.emailSingInTapped)
            .subscribe(onNext: store.dispatch)
            .disposed(by: disposeBag)                
    }
}

