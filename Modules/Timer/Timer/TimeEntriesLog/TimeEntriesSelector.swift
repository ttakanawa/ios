import Models

let timeEntriesSelector: (TimeEntriesLogState) -> [DayViewModel] = { state in

    guard case .loaded(_) = state.entities.loading else { return [] }
    return state.entities.timeEntries.values
        .sorted(by: { $0.start > $1.start })
        .compactMap({ timeEntry in
            guard let workspace = state.entities.getWorkspace(timeEntry.workspaceId) else {
                //fatalError("Workspace missing")
                //TODO This shouldn't happen, what should we do here?
                return nil
            }

            let project = state.entities.getProject(timeEntry.projectId)

            return TimeEntryViewModel(
                timeEntry: timeEntry,
                workspace: workspace,
                project: project,
                client: state.entities.getClient(project?.clientId),
                task: state.entities.getTask(timeEntry.taskId),
                tags: timeEntry.tagIds?.compactMap(state.entities.getTag)
            )
        })
        .grouped(by: { $0.start.ignoreTimeComponents() })
        .map(DayViewModel.init)
        .sorted(by: { $0.day > $1.day })
}
