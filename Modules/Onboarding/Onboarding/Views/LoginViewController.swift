//
//  LoginViewController.swift
//  Login
//
//  Created by Ricardo Sánchez Sotres on 13/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Architecture
import Models
import API

public class LoginViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Onboarding"
    public static var storyboardBundle = Bundle(for: LoginViewController.self as AnyClass)

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    public weak var store: OnboardingStore!
    public weak var coordinator: OnboardingCoordinator!

    public override func viewDidLoad()
    {
        super.viewDidLoad()
                
        emailTextField.rx.text.orEmpty
            .map(OnboardingAction.emailEntered)
            .bind(onNext: store.dispatch)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty
            .map(OnboardingAction.passwordEntered)
            .bind(onNext: store.dispatch)
            .disposed(by: disposeBag)

        store.state
            .map({ $0.loginButtonEnabled })
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .mapTo(OnboardingAction.loginTapped)
            .subscribe(onNext: store.dispatch)
            .disposed(by: disposeBag)
        
        store.state
            .map{ $0.user.description }
            .drive(userLabel.rx.text)
            .disposed(by: disposeBag)
        
        store.state
            .map{ $0.user.isLoaded }
            .filter({ $0 })
            .distinctUntilChanged()
            .drive(onNext: { [weak self] _ in
                self?.dismiss(animated: true) {
                    self?.coordinator.loggedIn?()
                }
            })
            .disposed(by: disposeBag)
    }
        
    public override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
    }
}
