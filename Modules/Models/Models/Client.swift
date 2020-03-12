import Foundation

public struct Client: Codable, Entity {
    
    public var id: Int
    public var name: String
    
    public var workspaceId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    
        case workspaceId = "wid"
    }
}
