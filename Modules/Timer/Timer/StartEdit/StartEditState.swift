import Foundation
import Models
import Utils

public struct StartEditState
{
    var user: Loadable<User>
    var entities: TimeLogEntities
    var description: String
}
