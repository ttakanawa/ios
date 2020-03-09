import UIKit
import Architecture

public final class EmailLoginCoordinator: NavigationCoordinator
{
    private var store: Store<OnboardingState, EmailLoginAction>
        
    public init(store: Store<OnboardingState, EmailLoginAction>) {
        self.store = store
        super.init()
    }
    
    public override func start()
    {
        let vc = LoginViewController.instantiate()
        vc.store = store
        navigationController.pushViewController(vc, animated: true)
    }
}
