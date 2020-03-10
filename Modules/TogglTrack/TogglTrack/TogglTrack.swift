import UIKit
import Architecture
import RxSwift
import Onboarding
import API
import Repository
import Networking
import Models

public class TogglTrack
{
    private let store: Store<AppState, AppAction>!
    private let appCoordinator: AppCoordinator
    private let router: Router
    private var disposeBag = DisposeBag()

    public init(window: UIWindow)
    {
        let appFeature = AppFeature()
        
        store = Store(
            initialState: AppState(),
            reducer: logging(appReducer),
            environment: AppEnvironment()
        )
        
        appCoordinator = appFeature.mainCoordinator(store: store) as! AppCoordinator
        router = Router(initialCoordinator: appCoordinator)
                
        store
            .select({ $0.route.path })
            .distinctUntilChanged()
            .do(onNext: { print("Route: \($0)") })
            .drive(onNext: router.navigate)
            .disposed(by: disposeBag)
        
        appCoordinator.start(window: window)
        store.dispatch(.start)                
    }
}
