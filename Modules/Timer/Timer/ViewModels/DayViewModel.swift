//
//  DayViewModel.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Utils

public struct DayViewModel
{    
    public var day: Date
    public var dayString: String
    public var timeEntries: [TimeEntryViewModel]
    
    public init(timeEntries: [TimeEntryViewModel])
    {
        day = timeEntries.first!.start.ignoreTimeComponents()
        dayString = day.toDayString()
        self.timeEntries = timeEntries
    }
}
