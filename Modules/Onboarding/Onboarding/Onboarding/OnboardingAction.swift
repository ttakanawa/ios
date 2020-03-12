import Foundation
import Models

public enum OnboardingAction {
    case emailSingInTapped    
    case emailLogin(EmailLoginAction)
    case emailSignup(EmailSignupAction)
}

extension OnboardingAction {
    var emailLogin: EmailLoginAction? {
        get {
            guard case let .emailLogin(value) = self else { return nil }
            return value
        }
        set {
            guard case .emailLogin = self, let newValue = newValue else { return }
            self = .emailLogin(newValue)
        }
    }
    
    var emailSignup: EmailSignupAction? {
        get {
            guard case let .emailSignup(value) = self else { return nil }
            return value
        }
        set {
            guard case .emailSignup = self, let newValue = newValue else { return }
            self = .emailSignup(newValue)
        }
    }
}

extension OnboardingAction: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .emailSingInTapped:
            return "EmailSignInTapped"
        case let .emailLogin(action):
            return action.debugDescription
        case let .emailSignup(action):
            return action.debugDescription
        }
    }
}
