import Foundation
import Models

public enum EmailLoginAction {
    case goToSignup
    case cancel

    case emailEntered(String)
    case passwordEntered(String)
    case loginTapped

    case setUser(User)
    case setError(Error)
}

extension EmailLoginAction: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .goToSignup:
            return "GoToSignUp"
        case .cancel:
            return "Cancel"
        case let .emailEntered(email):
            return "EmailEntered: \(email)"
        case let .passwordEntered(password):
            return "PasswordEntered: \(password.map({ _ in "*" }).joined())"
        case .loginTapped:
            return "LogginTapped"
        case let .setUser(user):
            return "SetUser: \(user.id)"
        case let .setError(error):
            return "SetError: \(error)"
        }
    }
}
