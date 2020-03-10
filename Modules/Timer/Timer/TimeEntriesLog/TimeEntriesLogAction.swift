import Foundation
import Models

public enum SwipeDirection {
    case left
    case right
}

public enum TimeEntriesLogAction {
    case continueButtonTapped(Int)
    case timeEntrySwiped(SwipeDirection, Int)
    case timeEntryTapped(Int)

    case timeEntryDeleted(Int)
    case timeEntryAdded(TimeEntry)

    case load
    case finishedLoading
    case setEntities([Entity])
    case setError(Error)
}

extension TimeEntriesLogAction: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {

        case let .continueButtonTapped(timeEntryId):
            return "ContinueButtonTapped: \(timeEntryId)"

        case let .timeEntrySwiped(direction, timeEntryId):
            return "TimeEntrySwiped \(direction): \(timeEntryId)"

        case let .timeEntryTapped(timeEntryId):
            return "TimeEntryTapped: \(timeEntryId)"

        case let .timeEntryDeleted(timeEntryId):
            return "TimeEntryDeleted: \(timeEntryId)"

        case let .timeEntryAdded(timeEntry):
            return "TimeEntryAdded: \(timeEntry.description)"

        case .load:
            return "Load"

        case .finishedLoading:
            return "FinishedLoading"

        case let .setEntities(entities):
            guard let first = entities.first else { return "SetEntities: 0" } // TODO Extract specific type from array
            return "SetEntities (\(type(of: first))): \(entities.count)"

        case let .setError(error):
            return "SetError: \(error)"
        }
    }
}
