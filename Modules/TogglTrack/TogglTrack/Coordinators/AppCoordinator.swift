import UIKit
import Architecture

public final class AppCoordinator: NavigationCoordinator
{
    private let store: Store<AppState, AppAction>
    private let onboardingCoordinator: Coordinator
    private let tabBarCoordinator: Coordinator
    
    public init(
        store: Store<AppState, AppAction>,
        onboardingCoordinator: Coordinator,
        tabBarCoordinator: Coordinator)
    {
        self.store = store
        self.onboardingCoordinator = onboardingCoordinator
        self.tabBarCoordinator = tabBarCoordinator
    }
    
    public func start(window: UIWindow)
    {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()        
    }
    
    public override func start()
    {
        fatalError("user start(window:) for the main coordinator")
    }
    
    public override func newRoute(route: String) -> Coordinator?
    {
        guard let route = AppRoute(rawValue: route) else { fatalError() }
        
        switch route {

        case .loading:
            return nil
            
        case .onboarding:
            return onboardingCoordinator
            
        case .main:
            return tabBarCoordinator
            
        }
    }
    
    public override func finish(completion: (() -> Void)?)
    {
        fatalError("Should never complete")
    }
}

class LoadingViewController: UIViewController
{
    public var store: Store<AppState, AppAction>!
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
}
