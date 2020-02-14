//
//  OnboardingPresenter.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 14/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import UIKit

public final class OnboardingPresenter
{
    public static var mainView: OnboardingViewController
    {
        let storyboardBundle = Bundle(for: self)
        let storyboard = UIStoryboard(name: "Onboarding", bundle: storyboardBundle)
        let vc = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        return vc
    }
}
