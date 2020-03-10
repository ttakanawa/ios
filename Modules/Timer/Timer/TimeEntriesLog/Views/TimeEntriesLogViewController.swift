import UIKit
import Utils
import Assets
import Architecture
import RxCocoa
import RxSwift
import RxDataSources
import Models

public typealias TimeEntriesLogStore = Store<TimeEntriesLogState, TimeEntriesLogAction>

public class TimeEntriesLogViewController: UIViewController, Storyboarded {
    public static var storyboardName = "Timer"
    public static var storyboardBundle = Assets.bundle

    @IBOutlet weak var tableView: UITableView!

    private var disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedAnimatedDataSource<DayViewModel>!

    public var store: TimeEntriesLogStore!

    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 72
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if dataSource == nil {
            // We should do this in ViewDidLoad, but there's a bug that causes an ugly warning. That's why we are doing it here for now
            dataSource = RxTableViewSectionedAnimatedDataSource<DayViewModel>(configureCell: { [weak self] _, tableView, indexPath, item in
                    let cell = tableView.dequeueReusableCell(withIdentifier: "TimeEntryCell", for: indexPath) as! TimeEntryCell
                    cell.descriptionLabel.text = item.description
                    cell.descriptionLabel.textColor = item.descriptionColor
                    cell.projectClientTaskLabel.textColor = item.projectColor
                    cell.projectClientTaskLabel.text = item.projectTaskClient
                    cell.durationLabel.text = item.durationString
                    cell.continueButton.rx.tap
                        .mapTo(TimeEntriesLogAction.continueButtonTapped(item.id))
                        .subscribe(onNext: self?.store.dispatch)
                        .disposed(by: cell.disposeBag)
                    return cell
            })

            dataSource.canEditRowAtIndexPath = { _, _ in true }

            dataSource.titleForHeaderInSection = { dataSource, index in
              return dataSource.sectionModels[index].dayString
            }

            store.select(timeEntriesSelector)
                .drive(tableView.rx.items(dataSource: dataSource!))
                .disposed(by: disposeBag)

            tableView.rx.modelSelected(TimeEntryViewModel.self)
                .map({ timeEntry in TimeEntriesLogAction.timeEntryTapped(timeEntry.id) })
                .subscribe(onNext: store.dispatch)
                .disposed(by: disposeBag)

            tableView.rx.setDelegate(self)
                .disposed(by: disposeBag)
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.dispatch(.load)
    }
}

extension TimeEntriesLogViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Continue") { _, _, _ in
            let timeEntryId = self.dataSource.sectionModels[indexPath.section].items[indexPath.item].id
            self.store.dispatch(TimeEntriesLogAction.timeEntrySwiped(.right, timeEntryId))
        }
        action.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [action])
    }

    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            let timeEntryId = self.dataSource.sectionModels[indexPath.section].items[indexPath.item].id
            self.store.dispatch(TimeEntriesLogAction.timeEntrySwiped(.left, timeEntryId))
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

// ANIMATED DATASOURCE EXTENSIONS

extension TimeEntryViewModel: IdentifiableType {
    public var identity: Int { id }
}

extension DayViewModel: AnimatableSectionModelType {
    public init(original: DayViewModel, items: [TimeEntryViewModel]) {
        self = original
        self.timeEntries = items
    }

    public var identity: Date { day }
    public var items: [TimeEntryViewModel] { timeEntries }
}
