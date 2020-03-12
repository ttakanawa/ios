import UIKit
import Architecture

public final class OnboardingCoordinator: BaseCoordinator {
    private var store: Store<OnboardingState, OnboardingAction>
    private var features: [String: BaseFeature<OnboardingState, OnboardingAction>]
    
    public init(store: Store<OnboardingState, OnboardingAction>, features: [String: BaseFeature<OnboardingState, OnboardingAction>]) {
        self.store = store
        self.features = features
    }
    
    public override func present(from presentingViewController: UIViewController) {
        let viewController = OnboardingViewController.instantiate()
        viewController.store = store
        presentingViewController.show(viewController, sender: nil)
        self.rootViewController = viewController
    }
    
    public override func newRoute(route: String) -> Coordinator? {
        guard let route = OnboardingRoute(rawValue: route) else { fatalError() }
        
        switch route {
        
        case .emailLogin:
            return features[route.rawValue]?.mainCoordinator(store: store)
        case .emailSignup:
            return features[route.rawValue]?.mainCoordinator(store: store)
        }
    }
}
