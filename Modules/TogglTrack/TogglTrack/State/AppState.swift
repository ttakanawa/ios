import Foundation
import Models
import Architecture
import Onboarding
import Timer
import Utils

public struct AppState {
    public var route: Route = AppRoute.loading
    public var user: Loadable<User> = .nothing
    public var entities: TimeLogEntities =  TimeLogEntities()
    
    public var localOnboardingState: LocalOnboardingState = LocalOnboardingState()
    public var localTimerState: LocalTimerState = LocalTimerState()
}

// Module specific states
extension AppState {
    var onboardingState: OnboardingState {
        get {
            OnboardingState(
                user: user,
                route: route,
                localOnboardingState: localOnboardingState
            )
        }
        set {
            user = newValue.user
            route = newValue.route
            localOnboardingState = newValue.localOnboardingState
        }
    }
    
    var timerState: TimerState {
        get {
            TimerState(
                user: user,
                entities: entities,
                localTimerState: localTimerState
            )
        }
        
        set {
            user = newValue.user
            entities = newValue.entities
            localTimerState = newValue.localTimerState
        }
    }
}
