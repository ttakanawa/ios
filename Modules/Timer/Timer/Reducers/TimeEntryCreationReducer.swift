//
//  TimeEntryCreationReducer.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift
import Models
import Architecture
import Repository

public func startify(
    _ reducer: Reducer<TimerState, TimerAction, Repository>
) -> Reducer<TimerState, TimerAction, Repository>
{
    return Reducer<TimerState, TimerAction, Repository> { state, action, repository in
        
        switch action {
            
        case let .timeLog(.cellSwipedLeft(id)):
            return deleteTimeEntry(repository, timeEntryId: id)
            
        case let .timeLog(.cellSwipedRight(id)):
            guard let timeEntry = state.entities.timeEntries[id] else { fatalError() }
            return continueTimeEntry(repository, timeEntry: timeEntry)
           
        case .startEdit(.startTapped):
            guard let defaultWorkspace = state.user.value?.defaultWorkspace else {
                fatalError("No default workspace")
            }
            
            let timeEntry = TimeEntry(
                id: state.entities.timeEntries.count,
                description: state.startEditState.description,
                start: Date(),
                duration: -1,
                billable: false,
                workspaceId: defaultWorkspace
            )
                        
            state.startEditState.description = ""
            return startTimeEntry(timeEntry, repository: repository)
            
        case let .timeEntryDeleted(timeEntryId):
            state.entities.timeEntries[timeEntryId] = nil
            
        case let .timeEntryAdded(timeEntry):
            state.entities.timeEntries[timeEntry.id] = timeEntry
            
        default:
            break
        }
        
        return reducer.reduce(&state, action, repository)
    }
}

fileprivate func deleteTimeEntry(_ repository: Repository, timeEntryId: Int) -> Effect<TimerAction>
{
    repository.deleteTimeEntry(timeEntryId: timeEntryId)
    .toEffect(
        map: { TimerAction.timeEntryDeleted(timeEntryId) },
        catch: { TimerAction.setError($0)} )
}

fileprivate func continueTimeEntry(_ repository: Repository, timeEntry: TimeEntry) -> Effect<TimerAction>
{
    var copy = timeEntry
    copy.id = UUID().hashValue
    copy.start = Date()
    copy.duration = -1
    
    return repository.addTimeEntry(timeEntry: copy)
    .toEffect(
        map: { TimerAction.timeEntryAdded(copy) },
        catch: { TimerAction.setError($0)} )
}

func startTimeEntry(_ timeEntry: TimeEntry, repository: Repository) -> Effect<TimerAction>
{
    return repository.addTimeEntry(timeEntry: timeEntry)
        .toEffect(
            map: { TimerAction.timeEntryAdded(timeEntry) },
            catch: { TimerAction.setError($0)} )
}
