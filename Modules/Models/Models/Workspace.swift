import Foundation

public struct Workspace: Codable, Entity {
    
    public var id: Int
    public var name: String
    public var admin: Bool
    
     enum CodingKeys: String, CodingKey {
         case id
         case name
         case admin
     }
}
