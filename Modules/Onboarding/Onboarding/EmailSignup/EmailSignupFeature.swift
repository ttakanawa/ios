import Foundation
import Architecture

class EmailSignupFeature: BaseFeature<OnboardingState, EmailSignupAction> {
    override func mainCoordinator(store: Store<OnboardingState, EmailSignupAction>) -> Coordinator {
        return EmailSignupCoordinator(store: store)
    }
}
