import Foundation
import Architecture

class StartEditFeature: BaseFeature<StartEditState, StartEditAction> {
    override func mainCoordinator(store: Store<StartEditState, StartEditAction>) -> Coordinator {
        return StartEditCoordinator(store: store)
    }
}
