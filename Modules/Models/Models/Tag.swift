import Foundation

public struct Tag: Codable, Entity
{
    public var id: Int
    public var name: String
    
    public var workspaceId: Int

    enum CodingKeys: String, CodingKey
    {
        case id
        case name
        
        case workspaceId = "workspace_id"
    }
}
