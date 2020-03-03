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

public typealias TimerStore = Store<TimerState, TimerAction>

public class TimerViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Timer"
    public static var storyboardBundle = Assets.bundle

    private var disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, TimeEntryViewModel>>?
    
    private var bottomSheet: BottomSheetView!
    
    public var store: TimerStore!
    public var startEditViewController: StartEditViewController!
    
    @IBOutlet weak var tableView: UITableView!
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Timer"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.rowHeight = 72

        bottomSheet = BottomSheetView(parentViewController: self)
        view.addSubview(bottomSheet)
        bottomSheet.containedViewController = startEditViewController
    }
    
    public override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        store.dispatch(.load)
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
