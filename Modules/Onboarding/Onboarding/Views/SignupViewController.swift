//
//  SignupViewController.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 21/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Architecture
import Models
import API
import Utils
import Assets

public typealias EmailSignupStore = Store<OnboardingState, EmailSignupAction>

class SignupViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Onboarding"
    public static var storyboardBundle = Bundle(for: Assets.self as AnyClass)

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    public weak var store: EmailSignupStore!
    public weak var coordinator: OnboardingCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIBarButtonItem(title: "Login", style: .plain, target: nil, action: nil)
        button.rx.tap
            .bind(onNext: coordinator.showEmailSignIn)
            .disposed(by: disposeBag)
        navigationItem.rightBarButtonItem = button
        
        store.select({ $0.email })
            .drive(emailTextField.rx.text)
            .disposed(by: disposeBag)
        
        store.select({ $0.password })
            .drive(passwordTextField.rx.text)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.compactMap({ $0 })
            .map(EmailSignupAction.emailEntered)
            .bind(onNext: store.dispatch)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.compactMap({ $0 })
            .map(EmailSignupAction.passwordEntered)
            .bind(onNext: store.dispatch)
            .disposed(by: disposeBag)
        
        store.select(loginButtonEnabled)
            .drive(signupButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signupButton.rx.tap
            .mapTo(EmailSignupAction.signupTapped)
            .subscribe(onNext: store.dispatch)
            .disposed(by: disposeBag)
        
        store.select(userDescription)
            .drive(userLabel.rx.text)
            .disposed(by: disposeBag)
        
        //             store.select(userIsLoaded)
        //                 .filter({ $0 })
        //                 .drive(onNext: { [weak self] _ in
        //                     self?.dismiss(animated: true) {
        //                         self?.coordinator.loggedIn?()
        //                     }
        //                 })
        //                 .disposed(by: disposeBag)
    }
}
