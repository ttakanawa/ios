//
//  TimeLogReducer.swift
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

public let timeLogReducer = Reducer<TimerState, TimeLogAction, Repository> { state, action, repository in
    switch action {
        
    case .load:
        if state.entities.loading.isLoaded {
            break
        }
        
        state.entities.loading = .loading
        return loadEntities(repository)
        
    case .finishedLoading:
        state.entities.loading = .loaded(())
        
    case let .setEntities(entities):
        
        let dict: [Int: Entity] = entities.reduce([:], { acc, e in
            var acc = acc
            acc[e.id] = e
            return acc
        })
        
        state.entities.set(entities: dict)
        
    case let .setError(error):
        state.entities.loading = .error(error)
    }
    
    return .empty
}


fileprivate func loadEntities(_ repository: Repository) -> Effect<TimeLogAction>
{
    Observable.merge(
        repository.getWorkspaces().map(TimeLogAction.setEntities),
        repository.getClients().map(TimeLogAction.setEntities),
        repository.getTimeEntries().map(TimeLogAction.setEntities),
        repository.getProjects().map(TimeLogAction.setEntities),
        repository.getTasks().map(TimeLogAction.setEntities),
        repository.getTags().map(TimeLogAction.setEntities)
    )
    .concat(Observable.just(.finishedLoading))
    .catchError({ Observable.just(.setError($0)) })
    .toEffect()
}
