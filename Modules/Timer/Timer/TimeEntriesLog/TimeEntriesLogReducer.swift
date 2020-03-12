import Foundation
import Architecture
import Models
import RxSwift
import Repository

let timeEntriesLogReducer = Reducer<TimeEntriesLogState, TimeEntriesLogAction, Repository> { state, action, repository in
    switch action {
        
    case let .continueButtonTapped(timeEntryId):
        guard let timeEntry = state.entities.timeEntries[timeEntryId] else { fatalError() }
        return continueTimeEntry(repository, timeEntry: timeEntry)
        
    case let .timeEntrySwiped(direction, timeEntryId):
        switch direction {
        case .left:
            return deleteTimeEntry(repository, timeEntryId: timeEntryId)
        case .right:
            guard let timeEntry = state.entities.timeEntries[timeEntryId] else { fatalError() }
            return continueTimeEntry(repository, timeEntry: timeEntry)
        }
        
    case let .timeEntryTapped(timeEntryId):
        //TODO Probably change the route to show the selected TE...
        return .empty
        
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
        let dict: [Int: Entity] = entities.reduce([:], { acc, entity in
            var acc = acc
            acc[entity.id] = entity
            return acc
        })
        
        state.entities.set(entities: dict)
        return .empty
        
    case let .setError(error):
        state.entities.loading = .error(error)
        return .empty
    }
}

private func loadEntities(_ repository: Repository) -> Effect<TimeEntriesLogAction> {
    //TODO Shouldn't need to do all that `asObservable`
    return Observable.merge(
        repository.getWorkspaces().map(TimeEntriesLogAction.setEntities).asObservable(),
        repository.getClients().map(TimeEntriesLogAction.setEntities).asObservable(),
        repository.getTimeEntries().map(TimeEntriesLogAction.setEntities).asObservable(),
        repository.getProjects().map(TimeEntriesLogAction.setEntities).asObservable(),
        repository.getTasks().map(TimeEntriesLogAction.setEntities).asObservable(),
        repository.getTags().map(TimeEntriesLogAction.setEntities).asObservable()
    )
    .concat(Observable.just(.finishedLoading))
    .catchError({ Observable.just(.setError($0)) })
    .toEffect()
}

private func deleteTimeEntry(_ repository: Repository, timeEntryId: Int) -> Effect<TimeEntriesLogAction> {
    repository.deleteTimeEntry(timeEntryId: timeEntryId)
    .toEffect(
        map: { TimeEntriesLogAction.timeEntryDeleted(timeEntryId) },
        catch: { TimeEntriesLogAction.setError($0)}
    )
}

private func continueTimeEntry(_ repository: Repository, timeEntry: TimeEntry) -> Effect<TimeEntriesLogAction> {
    
    var copy = timeEntry
    copy.id = UUID().hashValue
    copy.start = Date()
    copy.duration = -1
    
    return repository.addTimeEntry(timeEntry: copy)
    .toEffect(
        map: { TimeEntriesLogAction.timeEntryAdded(copy) },
        catch: { TimeEntriesLogAction.setError($0)}
    )
}
