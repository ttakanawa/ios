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

public typealias StartEditStore = Store<TimerState, TimerAction>

public class StartEditViewController: UIViewController, Storyboarded
{
    public static var storyboardName = "Timer"
    public static var storyboardBundle = Assets.bundle
    
    @IBOutlet weak var playStopButton: PlayStopButton!
    @IBOutlet weak var descriptionField: UITextField!
    
    public var store: StartEditStore!
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
