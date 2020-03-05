//
//  SceneDelegate.swift
//  App
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import TogglTrack

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
    var togglTrack: TogglTrack!
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // If we ever want to have multiple windows we should share the store and not create one for every TogglTrack instance
        window = UIWindow(windowScene: windowScene)
        togglTrack = TogglTrack(window: window!)
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
//        togglTrack.didBecomeActive()
    }
    
    func sceneWillResignActive(_ scene: UIScene)
    {        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene)
    {
//        togglTrack.enteredBackground()
    }
}
