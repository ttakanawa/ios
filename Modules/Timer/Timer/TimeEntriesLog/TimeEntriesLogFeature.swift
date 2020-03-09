import Foundation
import Architecture

class TimeEntriesLogFeature: BaseFeature<TimeEntriesLogState, TimeEntriesLogAction>
{
    override func mainCoordinator(store: Store<TimeEntriesLogState, TimeEntriesLogAction>) -> Coordinator {
        return TimeEntriesLogCoordinator(store: store)
    }
}

