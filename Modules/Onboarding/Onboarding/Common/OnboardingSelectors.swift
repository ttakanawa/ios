//
//  OnboardingSelectors.swift
//  Onboarding
//
//  Created by Ricardo Sánchez Sotres on 20/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation

let loginButtonEnabled: (OnboardingState) -> Bool = { state in
    state.email.count > 5 && state.password.count > 5 && !state.user.isLoading
}

let userDescription: (OnboardingState) -> String = { state in
    state.user.description
}

let userIsLoaded: (OnboardingState) -> Bool = { state in
    state.user.isLoaded
}
