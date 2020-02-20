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

public let timeEntriesLogReducer = Reducer<TimeEntriesLogState, TimeEntriesLogAction, Repository> { state, action, repository in
    
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



fileprivate func loadTimeEntries(_ repository: Repository) -> Effect<TimeEntriesLogAction>
{
    return repository.getTimeEntries()
        .map({ TimeEntriesLogAction.setEntities($0) })
        .catchError({ Observable.just(TimeEntriesLogAction.setError($0)) })
        .toEffect()
}
