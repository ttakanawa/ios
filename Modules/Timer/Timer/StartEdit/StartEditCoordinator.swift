import UIKit
import Architecture

public final class StartEditCoordinator: BaseCoordinator
{
    private var store: Store<StartEditState, StartEditAction>
        
    public init(store: Store<StartEditState, StartEditAction>)
    {
        self.store = store
    }
    
    public override func start()
    {
        let vc = StartEditViewController.instantiate()
        vc.store = store
        self.rootViewController = vc
    }
}
