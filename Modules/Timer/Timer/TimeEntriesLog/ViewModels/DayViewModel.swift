import Foundation
import Utils

public struct DayViewModel
{    
    public var day: Date
    public var dayString: String
    public var timeEntries: [TimeEntryViewModel]
    
    public init(timeEntries: [TimeEntryViewModel])
    {
        day = timeEntries.first!.start.ignoreTimeComponents()
        dayString = day.toDayString()
        self.timeEntries = timeEntries
    }
}
