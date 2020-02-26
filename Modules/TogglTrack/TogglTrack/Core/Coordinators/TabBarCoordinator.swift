//
//  TabBarCoordinator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 26/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import Timer
import RxSwift

public final class TabBarCoordinator: Coordinator
{
    private var store: Store<AppState, AppAction>
    private var rootViewController: UIViewController
    
    private var tabBarController: UITabBarController
    private var disposeBag = DisposeBag()
    
    public init(rootViewController: UIViewController, store: Store<AppState, AppAction>) {
        self.store = store
        self.rootViewController = rootViewController
        tabBarController = UITabBarController()
        
        super.init("main")
        
        tabBarController.rx.didSelect
            .compactMap({ self.tabBarController.viewControllers?.firstIndex(of: $0) })
            .map(AppAction.tabBarTapped)
            .subscribe(onNext: store.dispatch)            
            .disposed(by: disposeBag)
        
        let timer = TimerViewController.instantiate()
        timer.store = store.view(
            state: { $0.timerState },
            action: { .timer($0) }
        )
        let timerNav = UINavigationController(rootViewController: timer)
        timerNav.tabBarItem = UITabBarItem(title: "Timer", image: nil, tag: 0)
        
        let reports = UIViewController()
        reports.view.backgroundColor = .orange
        let reportsNav = UINavigationController(rootViewController: reports)
        reportsNav.tabBarItem = UITabBarItem(title: "Reports", image: nil, tag: 1)
        
        let calendar = UIViewController()
        calendar.view.backgroundColor = .yellow
        let calendarNav = UINavigationController(rootViewController: calendar)
        calendarNav.tabBarItem = UITabBarItem(title: "Calendar", image: nil, tag: 2)

        tabBarController.setViewControllers([timerNav, reportsNav, calendarNav], animated: false)
        
        rootViewController.show(tabBarController, sender: nil)
    }
    
    public override func newRoute(route: String)
    {
        rootViewController = tabBarController
        switch route {
        case "timer":
            break
        case "reports":
            break
        case "calendar":
            break
        default:
            fatalError("Wrong path")
            break
        }
    }
    
    public override func childForPath(_ path: String) -> Coordinator?
    {
        switch path {
        default:
            fatalError("Wrong path")
        }
    }
}
