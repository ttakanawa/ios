//
//  TimeEntriesLogCoordinator.swift
//  Toggl-iOS
//
//  Created by Ricardo Sánchez Sotres on 18/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import UIExtensions

public class TimeEntriesLogCoordinator: Coordinator
{
    let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController)
    {
        self.navigationController = navigationController
    }
    
    public func start()
    {
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        navigationController.pushViewController(vc, animated: true)
    }
}
