import UIKit
import Architecture

public final class EmailSignupCoordinator: NavigationCoordinator {
    private var store: Store<OnboardingState, EmailSignupAction>

    public init(store: Store<OnboardingState, EmailSignupAction>) {
        self.store = store
    }

    public override func start() {
        let vc = SignupViewController.instantiate()
        vc.store = store
        navigationController.pushViewController(vc, animated: true)
    }

    public override func newRoute(route: String) -> Coordinator? {
        return nil
//        switch route {
//        case "start":
//            let vc = SignupViewController.instantiate()
//            vc.store = store
//
//            navigationViewController = UINavigationController(rootViewController: vc)
//            presentingViewController.present(navigationViewController!, animated: true)
//        default:
//            fatalError("Wrong path")
//        }
    }
}
