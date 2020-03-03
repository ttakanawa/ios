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


fileprivate func loadEntities(_ repository: Repository) -> Effect<TimerAction>
{
    Observable.merge(
        repository.getWorkspaces().map(TimerAction.setEntities),
        repository.getClients().map(TimerAction.setEntities),
        repository.getTimeEntries().map(TimerAction.setEntities),
        repository.getProjects().map(TimerAction.setEntities),
        repository.getTasks().map(TimerAction.setEntities),
        repository.getTags().map(TimerAction.setEntities)
    )
    .concat(Observable.just(TimerAction.finishedLoading))
    .catchError({ Observable.just(TimerAction.setError($0)) })
    .toEffect()
}
