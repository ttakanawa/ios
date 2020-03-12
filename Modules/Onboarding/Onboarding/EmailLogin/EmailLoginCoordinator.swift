import UIKit
import Architecture

public final class EmailLoginCoordinator: NavigationCoordinator {
    
    private var store: Store<OnboardingState, EmailLoginAction>
        
    public init(store: Store<OnboardingState, EmailLoginAction>) {
        self.store = store
        super.init()
    }
    
    public override func start() {
        let viewController = LoginViewController.instantiate()
        viewController.store = store
        navigationController.pushViewController(viewController, animated: true)
    }
}
