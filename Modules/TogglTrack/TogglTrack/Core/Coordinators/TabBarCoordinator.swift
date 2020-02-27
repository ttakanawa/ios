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
    public var route: AppRoute = .main(.timer)
    
    public var rootViewController: UIViewController

    private var store: Store<AppState, AppAction>
    private var tabBarController: UITabBarController
    private var disposeBag = DisposeBag()
    
    public init(rootViewController: UIViewController, store: Store<AppState, AppAction>) {
        self.store = store
        self.rootViewController = rootViewController
        tabBarController = UITabBarController()        
        
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
    
    public func newRoute(route: String)
    {
        rootViewController = tabBarController
        switch route {
        
        case "timer":
            tabBarController.selectedIndex = 0
            
        case "reports":
            tabBarController.selectedIndex = 1
            
        case "calendar":
            tabBarController.selectedIndex = 2
            
        default:
            fatalError("Wrong path")
            break
        }
    }
    
    public func finish(completion: (() -> Void)?)
    {
        //TODO FINISH
        completion?()
    }
}
