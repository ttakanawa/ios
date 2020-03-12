import Foundation
import Architecture
import Models
import RxSwift
import API

let emailLoginReducer = Reducer<OnboardingState, EmailLoginAction, UserAPI> { state, action, api in
    
    switch action {
    
    case .goToSignup:
        state.route = OnboardingRoute.emailSignup
    
    case .cancel:
        state.route = AppRoute.onboarding
    
    case let .emailEntered(email):
        state.email = email
        
    case let .passwordEntered(password):
        state.password = password
        
    case .loginTapped:
        state.user = .loading
        return loadUser(email: state.email, password: state.password, api: api)
        
    case let .setUser(user):
        state.user = .loaded(user)
        api.setAuth(token: user.apiToken)
        state.route = AppRoute.main
        
    case let .setError(error):
        state.user = .error(error)
    }
    
    return .empty
}

private func loadUser(email: String, password: String, api: UserAPI) -> Effect<EmailLoginAction> {
    return api.loginUser(email: email, password: password)
        .map({ EmailLoginAction.setUser($0) })
        .catchError({ Observable.just(EmailLoginAction.setError($0)) })
        .toEffect()
}
