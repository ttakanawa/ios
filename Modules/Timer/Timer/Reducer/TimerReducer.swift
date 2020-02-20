//
//  TimerReducer.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture
import Models
import RxSwift
import Repository

public let timerReducer = Reducer<TimerState, TimerAction, Repository> { state, action, repository in
    
    switch action {
        
    case .load:
        state.entities.timeEntries = .loading
        return loadTimeEntries(repository)
        
    case let .setEntities(timeEntries):
        let dict: [TimeEntry.ID: TimeEntry] = timeEntries.reduce([:], { acc, e in
            var acc = acc
            acc[e.id] = e
            return acc
        })
        
        state.entities.timeEntries = .loaded(dict)
        
    case let .setError(error):
        state.entities.timeEntries = .error(error)
        break
    }
    
    return .empty
}



fileprivate func loadTimeEntries(_ repository: Repository) -> Effect<TimerAction>
{
    return repository.getTimeEntries()
        .map({ TimerAction.setEntities($0) })
        .catchError({ Observable.just(TimerAction.setError($0)) })
        .toEffect()
}
