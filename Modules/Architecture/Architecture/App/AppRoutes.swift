import Foundation

public enum AppRoute: String, Route {
    public var root: Route? { nil }

    case loading
    case onboarding
    case main
}

public enum OnboardingRoute: String, Route {
    public var root: Route? { AppRoute.onboarding }

    case emailLogin
    case emailSignup
}

public enum EmailSignupRoute: String, Route {
    public var root: Route? { OnboardingRoute.emailSignup }

    case tos
}

public enum TabBarRoute: String, Route {
    public var root: Route? { AppRoute.main }

    case timer
    case reports
    case calendar
}
