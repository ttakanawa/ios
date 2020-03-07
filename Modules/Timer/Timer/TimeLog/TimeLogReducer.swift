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
        
    case let .cellSwipedRight(timeEntryId):
        guard let timeEntry = state.entities.timeEntries[timeEntryId] else { fatalError() }
        return continueTimeEntry(repository, timeEntry: timeEntry)
        
    case let .timeEntryDeleted(timeEntryId):
        state.entities.timeEntries[timeEntryId] = nil
        return .empty
        
    case let .timeEntryAdded(timeEntry):
        state.entities.timeEntries[timeEntry.id] = timeEntry
        return .empty
        
    case .load:
        if state.entities.loading.isLoaded {
            return .empty
        }
        
        state.entities.loading = .loading
        return loadEntities(repository)
        
    case .finishedLoading:
        state.entities.loading = .loaded(())
        return .empty
        
    case let .setEntities(entities):        
        let dict: [Int: Entity] = entities.reduce([:], { acc, e in
            var acc = acc
            acc[e.id] = e
            return acc
        })
        
        state.entities.set(entities: dict)
        return .empty
        
    case let .setError(error):
        state.entities.loading = .error(error)
        return .empty
    }
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
    .toEffect(
        map: { TimeLogAction.timeEntryDeleted(timeEntryId) },
        catch: { TimeLogAction.setError($0)}
    )
}

fileprivate func continueTimeEntry(_ repository: Repository, timeEntry: TimeEntry) -> Effect<TimeLogAction>
{
    var copy = timeEntry
    copy.id = UUID().hashValue
    copy.start = Date()
    copy.duration = -1
    
    return repository.addTimeEntry(timeEntry: copy)
    .toEffect(
        map: { TimeLogAction.timeEntryAdded(copy) },
        catch: { TimeLogAction.setError($0)}
    )
}
