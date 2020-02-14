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

public class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var disposeBag = DisposeBag()
    
    public var store: Store<User?, OnboardingAction>!
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    public override func viewDidAppear(_ animated: Bool)
    {    
        loginButton.rx.tap
            .subscribe(onNext: dispatchLoginTapAction)
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
}
