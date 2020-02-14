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

public class OnboardingViewController: UIViewController
{
    @IBOutlet weak var emailSignInButton: UIButton!

    private var disposeBag = DisposeBag()
    
    public var store: Store<User?, OnboardingAction>!

    public override func viewDidLoad()
    {
        super.viewDidLoad()

        emailSignInButton.rx.tap
            .subscribe(onNext: showEmailSignIn)
            .disposed(by: disposeBag)
    }
    
    private func showEmailSignIn()
    {
        let vc = storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.store = store
        present(vc, animated: true)
    }
}
