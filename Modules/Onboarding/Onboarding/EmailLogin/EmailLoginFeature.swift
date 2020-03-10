import UIKit
import Architecture

class EmailLoginFeature: BaseFeature<OnboardingState, EmailLoginAction> {
    override func mainCoordinator(store: Store<OnboardingState, EmailLoginAction>) -> Coordinator {
        return EmailLoginCoordinator(store: store)
    }
}
