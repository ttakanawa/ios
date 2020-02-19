import UIKit
import Onboarding
import Architecture
import Models
import PlaygroundSupport

let user: User? = nil
let store = Store.create(
    initialState: user,
    reducer: onboardingReducer
)

let vc = OnboardingPresenter.mainView
vc.store = store

PlaygroundPage.current.liveView = vc
