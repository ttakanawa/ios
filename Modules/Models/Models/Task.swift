import Foundation

public struct Task: Codable, Entity {
    public var id: Int
    public var name: String
    public var active: Bool
    public var estimatedSeconds: Int
    public var trackedSeconds: Int

    public var projectId: Int
    public var workspaceId: Int
    public var userId: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case active

        case estimatedSeconds = "estimated_seconds"
        case trackedSeconds = "tracked_seconds"
        case projectId = "project_id"
        case workspaceId = "workspace_id"
        case userId = "user_id"
    }
}
