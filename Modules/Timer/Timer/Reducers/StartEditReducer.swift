//
//  StartEditReducer.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 28/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture
import Models
import RxSwift
import Repository

public let startEditReducer = Reducer<TimerState, StartEditAction, Repository> { state, action, repository in
    
    switch action {
        
    case let .descriptionEntered(description):
        state.description = description
        
    case .startTapped:
        break
        
    case let .timeEntryStarted(timeEntry):
//        state.entities.timeEntries[timeEntry.id] = timeEntry
        break
    }
    
    return .empty
}

//
//fileprivate func startTimeEntry(_ repository: Repository) -> Effect<StartEditAction>
//{
//    return repository.sta()
//        .map({ TimerAction.setEntities($0) })
//        .catchError({ Observable.just(TimerAction.setError($0)) })
//        .toEffect()
//}
