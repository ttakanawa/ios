import Foundation
import Architecture
import Models
import RxSwift
import API

let emailSignupReducer = Reducer<OnboardingState, EmailSignupAction, UserAPI> { state, action, _ in

    switch action {

    case .goToLogin:
        state.route = OnboardingRoute.emailLogin
        break

    case .cancel:
        state.route = AppRoute.onboarding
        break

    case let .emailEntered(email):
        state.email = email

    case let .passwordEntered(password):
        state.password = password

    case .signupTapped:
        state.user = .loading
        return .empty

    case let .setError(error):
        state.user = .error(error)
    }

    return .empty
}
