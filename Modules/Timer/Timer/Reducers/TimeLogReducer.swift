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

let timeLogReducer = Reducer<TimeLogState, TimeLogAction, Repository> { state, action, repository in
    switch action {
        
    case let .cellSwipedLeft(timeEntryId):
        return deleteTimeEntry(repository, timeEntryId: timeEntryId)
        
    case let .timeEntryDeleted(timeEntryId):
        state.entities.timeEntries[timeEntryId] = nil
        return .empty
        
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
    //TODO Shouldn't need to do all that `asObservable`
    return Observable.merge(
        repository.getWorkspaces().map(TimeLogAction.setEntities).asObservable(),
        repository.getClients().map(TimeLogAction.setEntities).asObservable(),
        repository.getTimeEntries().map(TimeLogAction.setEntities).asObservable(),
        repository.getProjects().map(TimeLogAction.setEntities).asObservable(),
        repository.getTasks().map(TimeLogAction.setEntities).asObservable(),
        repository.getTags().map(TimeLogAction.setEntities).asObservable()
    )
    .concat(Observable.just(.finishedLoading))
    .catchError({ Observable.just(.setError($0)) })
    .toEffect()
}

fileprivate func deleteTimeEntry(_ repository: Repository, timeEntryId: Int) -> Effect<TimeLogAction>
{
    repository.deleteTimeEntry(timeEntryId: timeEntryId)
        .mapTo(TimeLogAction.timeEntryDeleted(timeEntryId))
        .catchError({ Observable.just(.setError($0)) })
        .toEffect()
}
