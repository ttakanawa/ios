import UIKit
import Onboarding
import Architecture
import Models
import API
import PlaygroundSupport

let user: User? = nil

let initialState = OnboardingState(
    user: .nothing,
    local: LocalOnboardingState()
)

let store = Store(
    initialState: initialState,
    reducer: onboardingReducer,
    environment: API(urlSession: URLSession(configuration: URLSessionConfiguration.default))
)

let nav = UINavigationController()
nav.preferredContentSize = CGSize(width: 375, height: 667)
let coordinator = OnboardingCoordinator(navigationController: nav, store: store)

PlaygroundPage.current.liveView = nav
PlaygroundPage.current.needsIndefiniteExecution = true

coordinator.start()
