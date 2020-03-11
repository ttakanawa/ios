import UIKit
import Architecture

public final class TimerCoordinator: NavigationCoordinator
{
    private var store: Store<TimerState, TimerAction>
    
    private let timeLogCoordinator: TimeEntriesLogCoordinator
    private let startEditCoordinator: StartEditCoordinator
    
    public init(store: Store<TimerState, TimerAction>, timeLogCoordinator: TimeEntriesLogCoordinator, startEditCoordinator: StartEditCoordinator)
    {
        self.store = store
        self.timeLogCoordinator = timeLogCoordinator
        self.startEditCoordinator = startEditCoordinator
    }
    
    public override func start()
    {
        timeLogCoordinator.start()
        startEditCoordinator.start()
        let vc = TimerViewController()
        vc.timeLogViewController = timeLogCoordinator.rootViewController as? TimeEntriesLogViewController
        vc.startEditViewController = startEditCoordinator.rootViewController as? StartEditViewController
        navigationController.pushViewController(vc, animated: true)
    }
}
