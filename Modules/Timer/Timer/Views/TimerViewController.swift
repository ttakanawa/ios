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
import RxDataSources
import Utils
import Assets

let timeEntries: (TimerState) -> [TimeEntry] = { state in
    
    guard case let .loaded(tes) = state.entities.timeEntries else { return [] }
    
    return Array(tes.values)
}

public typealias TimerStore = Store<TimerState, TimerAction>

public class TimerViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Timer"
    public static var storyboardBundle = Assets.bundle

    private var disposeBag = DisposeBag()
    
    public var store: TimerStore!
    
    @IBOutlet weak var tableView: UITableView!
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.rowHeight = 72
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, TimeEntry>>(configureCell:
        { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeEntryCell", for: indexPath) as! TimeEntryCell
            cell.descriptionLabel.text = item.description
            cell.startLabel.text = "This is a test"
            return cell
        })
        
        store.select(timeEntries)
            .map({ [SectionModel(model: "", items: $0 )] })
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.dispatch(.load)
    }
}
