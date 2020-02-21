import UIKit
import Timer
import Architecture
import Models
import API
import Networking
import Repository
import PlaygroundSupport

let user: User? = nil

struct MockTimerState: TimerState
{
    var entities: TimeLogEntities = TimeLogEntities()
}

var initialState = MockTimerState()

let store = Store(
    initialState: initialState,
    reducer: timerReducer,
    environment: Repository(api: API(urlSession: FakeURLSession()))
)

let nav = UINavigationController()
nav.preferredContentSize = CGSize(width: 375, height: 667)
let coordinator = TimerCoordinator(navigationController: nav, store: store)

PlaygroundPage.current.liveView = nav
PlaygroundPage.current.needsIndefiniteExecution = true

coordinator.start()

store.dispatch(.load)
