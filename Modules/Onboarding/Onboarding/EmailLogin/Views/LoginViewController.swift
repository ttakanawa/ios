import UIKit
import RxCocoa
import RxSwift
import Architecture
import Models
import API
import Utils
import Assets

public typealias EmailLoginStore = Store<OnboardingState, EmailLoginAction>


public class LoginViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Onboarding"
    public static var storyboardBundle = Assets.bundle

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    public var store: EmailLoginStore!

    public override func viewDidLoad()
    {
        super.viewDidLoad()
                
        let button = UIBarButtonItem(title: "SignUp", style: .plain, target: nil, action: nil)
        button.rx.tap
            .mapTo(EmailLoginAction.goToSignup)
            .bind(onNext: store.dispatch)
            .disposed(by: disposeBag)        
        navigationItem.rightBarButtonItem = button
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        cancelButton.rx.tap
            .mapTo(EmailLoginAction.cancel)
            .bind(onNext: store.dispatch)
            .disposed(by: disposeBag)
        navigationItem.leftBarButtonItem = cancelButton
        
        store.select({ $0.email })
            .drive(emailTextField.rx.text)
            .disposed(by: disposeBag)
        
        store.select({ $0.password })
            .drive(passwordTextField.rx.text)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.compactMap({ $0 })
            .map(EmailLoginAction.emailEntered)
            .bind(onNext: store.dispatch)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.compactMap({ $0 })
            .map(EmailLoginAction.passwordEntered)
            .bind(onNext: store.dispatch)
            .disposed(by: disposeBag)

        store.select(loginButtonEnabled)
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .mapTo(EmailLoginAction.loginTapped)
            .subscribe(onNext: store.dispatch)
            .disposed(by: disposeBag)
        
        store.select(userDescription)
            .drive(userLabel.rx.text)
            .disposed(by: disposeBag)
        
        self.navigationController?.presentationController?.delegate = self
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        store.dispatch(.emailEntered("ricardo@toggl.com"))
        store.dispatch(.passwordEntered("password"))
//        store.dispatch(.loginTapped)
    }
}

extension LoginViewController: UIAdaptivePresentationControllerDelegate
{
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        store.dispatch(.cancel)
    }
}
