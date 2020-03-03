//
//  StartEditViewController.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 28/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit
import Assets
import Utils
import Architecture
import RxSwift
import RxCocoa

public typealias StartEditStore = Store<TimerState, StartEditAction>

public class StartEditViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Timer"
    public static var storyboardBundle = Assets.bundle
    
    @IBOutlet weak var playStopButton: UIButton!
    @IBOutlet weak var descriptionField: UITextField!
    
    public var store: StartEditStore!
    private var disposeBag = DisposeBag()

    public override func viewDidLoad() {
        super.viewDidLoad()

        playStopButton.rx.tap
            .mapTo(StartEditAction.startTapped)
            .subscribe(onNext: store.dispatch)
            .disposed(by: disposeBag)
        
        descriptionField.rx.text.compactMap({ $0 })
            .map(StartEditAction.descriptionEntered)
            .bind(onNext: store.dispatch)
            .disposed(by: disposeBag)
    }
    
    public override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    public override func resignFirstResponder() -> Bool
    {
        descriptionField.resignFirstResponder()
        return super.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
