import Foundation
import Models
import RxSwift

public protocol TimelineAPI {
    func loadEntries() -> Single<[TimeEntry]>
    func loadWorkspaces() -> Single<[Workspace]>
    func loadClients() -> Single<[Client]>
    func loadProjects() -> Single<[Project]>
    func loadTags() -> Single<[Tag]>
    func loadTasks() -> Single<[Task]>
}
