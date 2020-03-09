import Foundation
import Models

public enum TimerAction
{
    case timeLog(TimeEntriesLogAction)
    case startEdit(StartEditAction)
}

extension TimerAction
{
    var timeLog: TimeEntriesLogAction? {
        get {
            guard case let .timeLog(value) = self else { return nil }
            return value
        }
        set {
            guard case .timeLog = self, let newValue = newValue else { return }
            self = .timeLog(newValue)
        }
    }
    
    var startEdit: StartEditAction?
    {
        get {
            guard case let .startEdit(value) = self else { return nil }
            return value
        }
        set {
            guard case .startEdit = self, let newValue = newValue else { return }
            self = .startEdit(newValue)
        }
    }
}


extension TimerAction: CustomDebugStringConvertible
{
    public var debugDescription: String
    {
        switch self {
       
        case let .timeLog(action):
            return action.debugDescription
            
        case let .startEdit(action):
            return action.debugDescription               
        
        }
    }
}
