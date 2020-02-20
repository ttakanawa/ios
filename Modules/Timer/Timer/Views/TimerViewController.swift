//
//  TimerViewController.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Architecture
import Models
import RxCocoa
import RxSwift

public class TimerViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Timer"
    public static var storyboardBundle =  Bundle(for: TimerViewController.self as AnyClass)

    private var disposeBag = DisposeBag()
    
    public var store: TimerStore!
    public var coordinator: TimerCoordinator!
    
    @IBOutlet weak var tableView: UITableView!
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}
