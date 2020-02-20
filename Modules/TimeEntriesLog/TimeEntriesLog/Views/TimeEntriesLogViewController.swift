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

public class TimeEntriesLogViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "TimeEntriesLog"
    public static var storyboardBundle =  Bundle(for: TimeEntriesLogViewController.self as AnyClass)

    private var disposeBag = DisposeBag()
    
    public var store: TimeEntriesLogStore!
    public var coordinator: TimeEntriesLogCoordinator!
    
    @IBOutlet weak var tableView: UITableView!
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        store.dispatch(.load)
        
        store.state
            .drive(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
}
