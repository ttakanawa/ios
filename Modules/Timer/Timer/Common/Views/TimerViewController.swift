import UIKit
import Architecture
import Models
import RxCocoa
import RxSwift
import Utils
import Assets

public class TimerViewController: UIViewController {
    public var startEditViewController: StartEditViewController!
    public var timeLogViewController: TimeEntriesLogViewController!

    private var bottomSheet: BottomSheet!

    public override func viewDidLoad() {
        super.viewDidLoad()

        title = "Timer"
        navigationController?.navigationBar.prefersLargeTitles = true

        install(timeLogViewController)

        bottomSheet = BottomSheet(viewController: startEditViewController)
        install(bottomSheet, customConstraints: true)
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        timeLogViewController.additionalSafeAreaInsets.bottom = bottomSheet.view.frame.height
    }
}
