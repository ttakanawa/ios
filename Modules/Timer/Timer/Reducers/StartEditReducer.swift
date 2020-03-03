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

public let startEditReducer = Reducer<StartEditState, StartEditAction, Repository> { state, action, repository in
    
    switch action {
        
    case let .descriptionEntered(description):
        state.description = description
        
    case .startTapped:
        guard let defaultWorkspace = state.user.value?.defaultWorkspace else {
            fatalError("No default workspace")
        }
        
        let timeEntry = TimeEntry(
            id: state.entities.timeEntries.count,
            description: state.description,
            start: Date(),
            duration: -1,
            billable: false,
            workspaceId: defaultWorkspace
        )
        
        return startTimeEntry(timeEntry, repository: repository)
        
    case let .timeEntryStarted(timeEntry):
        state.description = ""
        state.entities.timeEntries[timeEntry.id] = timeEntry

    case let .setError(error):
        break
    }
    
    return .empty
}


func startTimeEntry(_ timeEntry: TimeEntry, repository: Repository) -> Effect<StartEditAction>
{
    return repository.addTimeEntry(timeEntry: timeEntry)
        .mapTo(StartEditAction.timeEntryStarted(timeEntry))
        .catchError({ Observable.just(StartEditAction.setError($0)) })
        .toEffect()
}
