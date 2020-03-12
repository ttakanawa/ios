import UIKit

public protocol Coordinator: AnyObject {
    var rootViewController: UIViewController! { get }
    func present(from: UIViewController)
    func finish(completion: (() -> Void)?)
    func newRoute(route: String) -> Coordinator?
}

open class BaseCoordinator: Coordinator {
    open var rootViewController: UIViewController!
    
    public init() {}
    
    open func present(from presentingViewController: UIViewController) {
        fatalError()
    }
    
    open func start() {
        fatalError()
    }
    
    open func finish(completion: (() -> Void)?) {
        completion?()
    }
    
    open func newRoute(route: String) -> Coordinator? {
        fatalError()
    }
}

open class NavigationCoordinator: BaseCoordinator {
    public let navigationController = UINavigationController()
    
    override public init() {
        super.init()
        rootViewController = navigationController
    }
    
    override public func present(from presentingViewController: UIViewController) {
        start()
        presentingViewController.show(navigationController, sender: self)
    }
    
    override open func start() {
        
    }
    
    open override func finish(completion: (() -> Void)?) {
        navigationController.dismiss(animated: true, completion: completion)
    }
}

open class TabBarCoordinator: BaseCoordinator {
    
    public let tabBarController = UITabBarController()
    
    override public init() {
        super.init()
        rootViewController = tabBarController
    }
    
    override public func present(from presentingViewController: UIViewController) {
        start()
        presentingViewController.show(tabBarController, sender: self)
    }
    
    override open func start() {
        
    }
    
    open override func finish(completion: (() -> Void)?) {
        tabBarController.dismiss(animated: true, completion: completion)
    }
}
