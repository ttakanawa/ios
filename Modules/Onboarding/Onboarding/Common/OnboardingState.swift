import Foundation
import Models
import Architecture
import Utils

public struct LocalOnboardingState
{
    internal var email: String = ""
    internal var password: String = ""
    
    public init()
    {
    }
}

public struct OnboardingState
{
    public var user: Loadable<User>
    public var route: Route
    public var localOnboardingState: LocalOnboardingState
    
    public init(user: Loadable<User>, route: Route, localOnboardingState: LocalOnboardingState) {
        self.user = user
        self.route = route
        self.localOnboardingState = localOnboardingState
    }
}

extension OnboardingState
{
    internal var email: String
    {
        get {
            localOnboardingState.email
        }
        set {
            localOnboardingState.email = newValue
        }
    }
    
    internal var password: String
    {
        get {
            localOnboardingState.password
        }
        set {
            localOnboardingState.password = newValue
        }
    }
}
