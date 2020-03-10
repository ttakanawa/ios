import UIKit
import Assets
import Utils
import Architecture
import RxSwift
import RxCocoa

public typealias StartEditStore = Store<StartEditState, StartEditAction>

public class StartEditViewController: UIViewController, Storyboarded {
    public static var storyboardName = "Timer"
    public static var storyboardBundle = Assets.bundle

    @IBOutlet weak var playStopButton: UIButton!
    @IBOutlet weak var descriptionField: UITextField!

    public var store: StartEditStore!
    private var disposeBag = DisposeBag()

    public override func viewDidLoad() {
        super.viewDidLoad()

        store.select({ $0.description })
            .drive(descriptionField.rx.text)
            .disposed(by: disposeBag)

        playStopButton.rx.tap
            .mapTo(StartEditAction.startTapped)
            .subscribe(onNext: store.dispatch)
            .disposed(by: disposeBag)

        descriptionField.rx.text.compactMap({ $0 })
            .map(StartEditAction.descriptionEntered)
            .bind(onNext: store.dispatch)
            .disposed(by: disposeBag)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    public override func resignFirstResponder() -> Bool {
        descriptionField.resignFirstResponder()
        return super.resignFirstResponder()
    }
}
