//
//  TimeEntriesLogReducer.swift
//  TimeEntriesLog
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture
import Models
import RxSwift
import Repository

public let timeEntriesLogReducer = Reducer<TimeEntriesLogState, TimeEntriesLogAction, Repository> { state, action, api in
    
    switch action {
        
    default:
        break
    }
    
    return .empty
}
