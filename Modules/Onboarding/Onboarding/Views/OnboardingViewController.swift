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

public class OnboardingViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Onboarding"
    public static var storyboardBundle =  Bundle(for: OnboardingViewController.self as AnyClass)
    
    @IBOutlet weak var emailSignInButton: UIButton!

    private var disposeBag = DisposeBag()
    
    public var store: OnboardingStore!
    public var coordinator: OnboardingCoordinator!

    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true

        emailSignInButton.rx.tap
            .subscribe(onNext: coordinator.showEmailSignIn)
            .disposed(by: disposeBag)    
    }
}
