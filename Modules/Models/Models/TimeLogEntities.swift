import Foundation

public struct TimeLogEntities {
    public var loading: Loadable<Void> = .nothing
    
    public var workspaces = [Int: Workspace]()
    public var clients = [Int: Client]()
    public var timeEntries = [Int: TimeEntry]()
    public var projects = [Int: Project]()
    public var tasks = [Int: Task]()
    public var tags = [Int: Tag]()
    
    public init() {
    }
    
    public mutating func set(entities: [Int: Entity]) {
        guard let first = entities.values.first else { return }
        
        switch first {
        case _ as Workspace:
            workspaces = (entities as? [Int: Workspace])!
        case _ as Client:
            clients = (entities as? [Int: Client])!
        case _ as TimeEntry:
            timeEntries = (entities as? [Int: TimeEntry])!
        case _ as Project:
            projects = (entities as? [Int: Project])!
        case _ as Task:
            tasks = (entities as? [Int: Task])!
        case _ as Tag:
            tags = (entities as? [Int: Tag])!
        default:
            break
        }
    }
    
    public func getWorkspace(_ id: Int?) -> Workspace? {
        guard let id = id else { return nil }
        return workspaces[id]
    }
    
    public func getClient(_ id: Int?) -> Client? {
        guard let id = id else { return nil }
        return clients[id]
    }
    
    public func getTimeEntry(_ id: Int?) -> TimeEntry? {
        guard let id = id else { return nil }
        return timeEntries[id]
    }
    
    public func getProject(_ id: Int?) -> Project? {
        guard let id = id else { return nil }
        return projects[id]
    }
    
    public func getTask(_ id: Int?) -> Task? {
        guard let id = id else { return nil }
        return tasks[id]
    }
    
    public func getTag(_ id: Int?) -> Tag? {
        guard let id = id else { return nil }
        return tags[id]
    }
}
