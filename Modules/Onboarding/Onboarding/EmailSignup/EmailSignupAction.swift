import Foundation
import Models

public enum EmailSignupAction
{
    case goToLogin
    case cancel
    
    case emailEntered(String)
    case passwordEntered(String)
    case signupTapped
    
    case setError(Error)
}

extension EmailSignupAction: CustomDebugStringConvertible
{
    public var debugDescription: String
    {
        switch self {
        case .goToLogin:
            return "GoToLogin"
        case .cancel:
            return "Cancel"
        case let .emailEntered(email):
            return "EmailEntered: \(email)"
        case let .passwordEntered(password):
            return "PasswordEntered: \(password.map({ _ in "*" }).joined())"
        case .signupTapped:
            return "SignupTapped"
        case let .setError(error):
            return "SetError: \(error)"
        }
    }
}
