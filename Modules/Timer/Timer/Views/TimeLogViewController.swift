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

// TODO Move this somewhere else
let timeEntries: (TimerState) -> [TimeEntryViewModel] = { state in
    
    guard case .loaded(_) = state.entities.loading else { return [] }
    return state.entities.timeEntries.values.compactMap({ timeEntry in
        
        guard let workspace = state.entities.getWorkspace(timeEntry.workspaceId) else {
//            fatalError("Workspace missing")
            //TODO This shouldn't happen, what should we do here?
            print("Workspace missing: \(timeEntry)")
            return nil
        }
        
        let project = state.entities.getProject(timeEntry.projectId)
        
        return TimeEntryViewModel(
            timeEntry: timeEntry,
            workspace: workspace,
            project: project,
            client: state.entities.getClient(project?.clientId),
            task: state.entities.getTask(timeEntry.taskId),
            tags: timeEntry.tagIds?.compactMap(state.entities.getTag)
        )
    })
}

class TimeLogViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Timer"
    public static var storyboardBundle = Assets.bundle

    @IBOutlet weak var tableView: UITableView!
    
    private var disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, TimeEntryViewModel>>?

    public var store: TimerStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 72
    }
    
    public override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
                
        if dataSource == nil {
            // We should do this in ViewDidLoad, but there's a bug that causes an ugly warning. That's why we are doing it here for now
            dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, TimeEntryViewModel>>(configureCell:
                { dataSource, tableView, indexPath, item in
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TimeEntryCell", for: indexPath) as! TimeEntryCell
                    cell.descriptionLabel.text = item.description
                    cell.descriptionLabel.textColor = item.descriptionColor
                    cell.projectClientTaskLabel.textColor = item.projectColor
                    cell.projectClientTaskLabel.text = item.projectTaskClient
                    cell.durationLabel.text = item.durationString
                    return cell
            })
            
            store.select(timeEntries)
                .map({ [SectionModel(model: "", items: $0 )] })
                .drive(tableView.rx.items(dataSource: dataSource!))
                .disposed(by: disposeBag)
        }
    }
}
