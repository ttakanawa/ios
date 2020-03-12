import Foundation
import Architecture
import RxSwift
import API

let mainOnboardingReducer = Reducer<OnboardingState, OnboardingAction, UserAPI> { state, action, _ in
    
    switch action {
        
    case .emailSingInTapped:
        state.route = OnboardingRoute.emailLogin
        
    case .emailLogin, .emailSignup:
        break
    }

    return .empty
}
