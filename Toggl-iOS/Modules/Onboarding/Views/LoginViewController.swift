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
import UIExtensions

public class LoginViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Onboarding"
    public static var storyboardBundle = Bundle(for: LoginViewController.self as AnyClass)

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    public weak var store: Store<Loadable<User>, OnboardingAction, API>!
    public weak var coordinator: OnboardingCoordinator!

    public override func viewDidLoad()
    {
        super.viewDidLoad()

        loginButton.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.dispatchLoginTapAction()
            })
            .disposed(by: disposeBag)
        
        store.state
            .map(toString)
            .bind(to: userLabel.rx.text)
            .disposed(by: disposeBag)
        
        store.state
            .filter(isLoaded)
            .take(1)
            .subscribe(onNext: { _ in
                self.dismiss(animated: true) {
                    self.coordinator.loggedIn?()
                }
            })
            .disposed(by: disposeBag)
    }

    private func dispatchLoginTapAction()
    {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {
                return
        }
        
        self.store.dispatch(.loginTapped(email: email, password: password))
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
