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

public final class MainCoordinator: TabBarCoordinator
{
    private var store: Store<AppState, AppAction>
    private var disposeBag = DisposeBag()
    
    private let timerCoordinator: TimerCoordinator
    
    public init(
        store: Store<AppState, AppAction>,
        timerCoordinator: TimerCoordinator
    )
    {
        self.store = store
        self.timerCoordinator = timerCoordinator
        
        super.init()
        
        tabBarController.rx.didSelect
            .compactMap({ self.tabBarController.viewControllers?.firstIndex(of: $0) })
            .map(AppAction.tabBarTapped)
            .subscribe(onNext: store.dispatch)            
            .disposed(by: disposeBag)


    }
    
    public override func start()
    {
        timerCoordinator.start()
        let timer = timerCoordinator.rootViewController!
        timer.tabBarItem = UITabBarItem(title: "Timer", image: nil, tag: 0)
        
        let reports = UIViewController()
        reports.view.backgroundColor = .orange
        let reportsNav = UINavigationController(rootViewController: reports)
        reportsNav.tabBarItem = UITabBarItem(title: "Reports", image: nil, tag: 1)
        
        let calendar = UIViewController()
        calendar.view.backgroundColor = .yellow
        let calendarNav = UINavigationController(rootViewController: calendar)
        calendarNav.tabBarItem = UITabBarItem(title: "Calendar", image: nil, tag: 2)

        tabBarController.setViewControllers([timer, reportsNav, calendarNav], animated: false)
    }
    
    public override func newRoute(route: String) -> Coordinator?
    {
        return nil
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
}
