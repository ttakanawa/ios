import UIKit
import Utils
import Assets

class BottomSheet: UIViewController {
    
    private var bottomConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    
    public var stops: [CGFloat] = [77]
    private var layedOut: Bool = false
    
    private let containedViewController: UIViewController
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewController: UIViewController) {
        containedViewController = viewController
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
        view.backgroundColor = .white
        
        install(containedViewController)
    }
    
    override func didMove(toParent parent: UIViewController?) {
        
        guard let parent = parent else { return }
                
        view.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: parent.view.trailingAnchor).isActive = true
        bottomConstraint = view.bottomAnchor.constraint(equalTo: parent.view.safeAreaLayoutGuide.bottomAnchor)
        heightConstraint = view.heightAnchor.constraint(equalToConstant: stops.first!)
        bottomConstraint.isActive = true
        heightConstraint.isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        guard !layedOut else { return }
        layedOut = true
        
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -6)
        view.layer.shadowRadius = 10.0
        view.layer.shadowOpacity = 0.2
    }
    
    @objc
    func panGesture(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: view)
        
        switch recognizer.state {
        case .changed:
            heightConstraint.constant -= translation.y
            
        case .ended, .cancelled:
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 1,
                options: [],
                animations: {
                    self.containedViewController.resignFirstResponder()
                    self.heightConstraint.constant = self.stops.first!
                    self.view.superview?.layoutIfNeeded()
            },
                completion: nil)
        default:
            break
        }
        
        recognizer.setTranslation(CGPoint.zero, in: view)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else { return }
        let keyboardFrame =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)!.cgRectValue
        
        let keyboardFrameInView = parent!.view.convert(keyboardFrame, from: nil)
        let safeAreaFrame = parent!.view.safeAreaLayoutGuide.layoutFrame
        let intersection = safeAreaFrame.intersection(keyboardFrameInView)
        
        UIView.animate(withDuration: 0.3) {
            self.parent?.additionalSafeAreaInsets.bottom = intersection.height
            self.parent?.view.layoutIfNeeded()
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        
        UIView.animate(withDuration: 0.3) {
            self.parent?.additionalSafeAreaInsets.bottom = 0
            self.parent?.view.layoutIfNeeded()
        }
    }
}
