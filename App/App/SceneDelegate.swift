//
//  SceneDelegate.swift
//  App
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import TogglTrack
import RxSwift

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
    var router: Router!
    var store: Store<AppState, AppAction>!
    private var disposeBag = DisposeBag()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        store = (UIApplication.shared.delegate as! AppDelegate).store
        
        let window = UIWindow(windowScene: windowScene)
        let coordinator = AppCoordinator(window: window, store: store)
        
        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()
        
        router = Router(initialCoordinator: coordinator)
        router.delegate = self
        
        store
            .select({ $0.route })
            .do(onNext: { print("Route: \($0)") })
            .distinctUntilChanged()
            .drive(onNext: router.navigate)
            .disposed(by: disposeBag)
        
        store.dispatch(.start)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene)
    {
        store.dispatch(.setForegroundStatus)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene)
    {
        store.dispatch(.setBackgroundStatus)
    }
}

extension SceneDelegate: RouterDelegate
{
    func coordinator(forRoute route: String, rootViewController: UIViewController) -> Coordinator
    {
        switch route {
        case "onboarding":
            return OnboardingCoordinator(rootViewController: rootViewController, store: store)
        case "main":
            return TabBarCoordinator(rootViewController: rootViewController, store: store)
        case "emailLogin":
            return EmailLoginCoordinator(presentingViewController: rootViewController, store: store)
        case "emailSignup":
            return EmailSignupCoordinator(presentingViewController: rootViewController, store: store)
        default:
            fatalError("Wrong path")
        }
    }
}
