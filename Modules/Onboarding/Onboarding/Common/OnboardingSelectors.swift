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
