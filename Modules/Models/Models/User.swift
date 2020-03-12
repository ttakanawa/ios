import Foundation

public struct User: Codable, Equatable {
    
    public var id: Int
    public var apiToken: String
    public var defaultWorkspace: Int

    enum CodingKeys: String, CodingKey {
        case id    
        case apiToken = "api_token"
        case defaultWorkspace = "default_workspace_id"
    }
}

extension User: CustomStringConvertible {
    public var description: String {
        return "\(id)"
    }
}
