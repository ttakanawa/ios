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
import Utils
import Assets

public typealias EmailLoginStore = Store<OnboardingState, EmailLoginAction>


public class LoginViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Onboarding"
    public static var storyboardBundle = Assets.bundle

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    public weak var store: EmailLoginStore!
    public weak var coordinator: OnboardingCoordinator!

    public override func viewDidLoad()
    {
        super.viewDidLoad()
                
        let button = UIBarButtonItem(title: "SignUp", style: .plain, target: nil, action: nil)
        button.rx.tap
            .bind(onNext: coordinator.showEmailSignUp)
            .disposed(by: disposeBag)        
        navigationItem.rightBarButtonItem = button
        
        store.select({ $0.email })
            .drive(emailTextField.rx.text)
            .disposed(by: disposeBag)
        
        store.select({ $0.password })
            .drive(passwordTextField.rx.text)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.compactMap({ $0 })
            .map(EmailLoginAction.emailEntered)
            .bind(onNext: store.dispatch)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.compactMap({ $0 })
            .map(EmailLoginAction.passwordEntered)
            .bind(onNext: store.dispatch)
            .disposed(by: disposeBag)

        store.select(loginButtonEnabled)
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .mapTo(EmailLoginAction.loginTapped)
            .subscribe(onNext: store.dispatch)
            .disposed(by: disposeBag)
        
        store.select(userDescription)
            .drive(userLabel.rx.text)
            .disposed(by: disposeBag)
        
        store.select(userIsLoaded)
            .filter({ $0 })
            .drive(onNext: { [weak self] _ in
                self?.dismiss(animated: true) {
                    self?.coordinator.loggedIn?()
                }
            })
            .disposed(by: disposeBag)
    }
}
