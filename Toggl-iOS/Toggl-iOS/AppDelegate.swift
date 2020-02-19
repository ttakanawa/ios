//
//  AppDelegate.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 12/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var coordinator: AppCoordinator?
    var store: Store<AppState, AppAction> = buildStore()

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        if #available(iOS 13, *) {
            return true
        }

        let window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = AppCoordinator(window: window, store: store)
        coordinator?.start()
                
        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
        // Not called under iOS 13 - See SceneDelegate sceneWillResignActive
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
        // Not called under iOS 13 - See SceneDelegate sceneDidEnterBackground
        store.dispatch(.setBackgroundStatus)
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
        // Not called under iOS 13 - See SceneDelegate sceneWillEnterForeground
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
        // Not called under iOS 13 - See SceneDelegate sceneWillEnterForeground
        store.dispatch(.setForegroundStatus)
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration
    {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>)
    {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

