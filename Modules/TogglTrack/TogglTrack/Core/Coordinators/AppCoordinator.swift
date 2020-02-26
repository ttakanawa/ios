//
//  AppCoordinator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 25/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import RxSwift

public final class AppCoordinator: Coordinator
{
    private let window: UIWindow
    private var store: Store<AppState, AppAction>
    private var rootViewController: UINavigationController? {
        didSet {
            window.rootViewController = rootViewController!
            window.makeKeyAndVisible()
        }
    }
    private var disposeBag = DisposeBag()
    
    public init(window: UIWindow, store: Store<AppState, AppAction>) {
        self.window = window
        self.store = store
        
        super.init("root")
        
        store
            .select({ $0.route.path })
            .do(onNext: { print($0) })
            .distinctUntilChanged()
            .drive(onNext: navigate)
            .disposed(by: disposeBag)
        
        store.dispatch(.start)
    }
        
    public override func newRoute(route: String)
    {
        switch route {
        case "start":
            rootViewController = UINavigationController()
            rootViewController?.navigationBar.isHidden = true
        default:
            fatalError("Wrong path")
        }
    }
    
    public override func childForPath(_ path: String) -> Coordinator?
    {
        switch path {
        case "onboarding":
            return OnboardingCoordinator(rootViewController: rootViewController!, store: store)
        case "main":
            return TabBarCoordinator(rootViewController: rootViewController!, store: store)
        default:
            fatalError("Wrong path")
        }
    }
}
