import Foundation
import Onboarding
import Timer
import Models

public enum AppAction {
    case start

    case tabBarTapped(Int)

    case onboarding(OnboardingAction)
    case timer(TimerAction)
    case startEdit(StartEditAction)
}

extension AppAction {
    var onboarding: OnboardingAction? {
        get {
            guard case let .onboarding(value) = self else { return nil }
            return value
        }
        set {
            guard case .onboarding = self, let newValue = newValue else { return }
            self = .onboarding(newValue)
        }
    }

    var timer: TimerAction? {
        get {
            guard case let .timer(value) = self else { return nil }
            return value
        }
        set {
            guard case .timer = self, let newValue = newValue else { return }
            self = .timer(newValue)
        }
    }

    var startEdit: StartEditAction? {
        get {
            guard case let .startEdit(value) = self else { return nil }
            return value
        }
        set {
            guard case .startEdit = self, let newValue = newValue else { return }
            self = .startEdit(newValue)
        }
    }
}

extension AppAction: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .start:
            return "Start"
        case let .tabBarTapped(tab):
            return "TabSelected: \(tab)"
        case let .onboarding(action):
            return action.debugDescription
        case let .timer(action):
            return action.debugDescription
        case let .startEdit(action):
            return action.debugDescription
        }
    }
}
