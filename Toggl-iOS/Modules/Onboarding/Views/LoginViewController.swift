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
import Common

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
            .subscribe(onNext: {[weak self] in
                self?.dispatchLoginTapAction()
            })
            .disposed(by: disposeBag)
        
        store.state
            .map{ $0.user }
            .map(toString)
            .drive(userLabel.rx.text)
            .disposed(by: disposeBag)
        
        store.state
            .map{ $0.user }
            .filter(isLoaded)
            .drive(onNext: { _ in
                self.dismiss(animated: true) {
                    self.coordinator.loggedIn?()
                }
            })
            .disposed(by: disposeBag)
    }

    private func dispatchLoginTapAction()
    {
        self.store.dispatch(.loginTapped)
    }
        
    public override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
    }
}

fileprivate func toString(loadableUser: Loadable<User>) -> String
{
    switch loadableUser {
        case .nothing:
            return "empty"
        case .loading:
            return "loading"
        case let .error(error):
            return "error: \(error)"
        case let .loaded(user):
            return "loaded: \(user.id)"
    }
}
