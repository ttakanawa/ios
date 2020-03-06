//
//  TimeLogViewController.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 03/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Utils
import Assets
import Architecture
import RxCocoa
import RxSwift
import RxDataSources
import Models

public typealias TimeLogStore = Store<TimeLogState, TimeLogAction>

public class TimeLogViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Timer"
    public static var storyboardBundle = Assets.bundle

    @IBOutlet weak var tableView: UITableView!
    
    private var disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedAnimatedDataSource<DayViewModel>!

    public var store: TimeLogStore!

    public override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.rowHeight = 72
    }
    
    public override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
                
        if dataSource == nil {
            // We should do this in ViewDidLoad, but there's a bug that causes an ugly warning. That's why we are doing it here for now
            dataSource = RxTableViewSectionedAnimatedDataSource<DayViewModel>(configureCell:
                { dataSource, tableView, indexPath, item in
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TimeEntryCell", for: indexPath) as! TimeEntryCell
                    cell.descriptionLabel.text = item.description
                    cell.descriptionLabel.textColor = item.descriptionColor
                    cell.projectClientTaskLabel.textColor = item.projectColor
                    cell.projectClientTaskLabel.text = item.projectTaskClient
                    cell.durationLabel.text = item.durationString
                    return cell
            })
            
            dataSource.titleForHeaderInSection = { dataSource, index in
              return dataSource.sectionModels[index].dayString
            }
            
            store.select(timeEntriesSelector)
                .drive(tableView.rx.items(dataSource: dataSource!))
                .disposed(by: disposeBag)
        }
    }
    
    public override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        store.dispatch(.load)
    }
}



// ANIMATED DATASOURCE EXTENSIONS

extension TimeEntryViewModel: IdentifiableType
{
    public var identity: Int { id }
}

extension DayViewModel: AnimatableSectionModelType
{
    public init(original: DayViewModel, items: [TimeEntryViewModel]) {
        self = original
        self.timeEntries = items
    }
    
    public var identity: Date { day }
    public var items: [TimeEntryViewModel] { timeEntries }
}
