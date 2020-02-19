//
//  TimeEntriesLogViewController.swift
//  TimeEntriesLog
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import Models
import RxCocoa
import RxSwift

public class TimeEntriesLogViewController: UIViewController
{
    private var disposeBag = DisposeBag()
    
    public var store: TimeEntriesLogStore!
    public var coordinator: TimeEntriesLogCoordinator!

    public override func viewDidLoad()
    {
        super.viewDidLoad()

        view.backgroundColor = .green
    }
}
