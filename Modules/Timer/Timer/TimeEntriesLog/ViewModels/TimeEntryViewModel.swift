import UIKit
import Models

public struct TimeEntryViewModel: Equatable
{
    public static func == (lhs: TimeEntryViewModel, rhs: TimeEntryViewModel) -> Bool
    {
        return lhs.description == rhs.description && lhs.projectTaskClient == rhs.projectTaskClient && lhs.billable == rhs.billable
            && lhs.start == rhs.start && lhs.duration == rhs.duration
            && lhs.end == rhs.end && lhs.isRunning == rhs.isRunning //&& lhs.tags == rhs.tags
    }
    
    public var id: Int
    public var description: String
    public var projectTaskClient: String
    public var billable: Bool
    
    public var start: Date
    public var duration: TimeInterval?
    public var durationString: String?
    public var end: Date?
    public var isRunning: Bool
    
    public var descriptionColor: UIColor
    public var projectColor: UIColor
    
    public let workspace: Workspace
    public let tags: [Tag]?
    
    public init(
        timeEntry: TimeEntry,
        workspace: Workspace,
        project: Project? = nil,
        client: Client? = nil,
        task: Task? = nil,
        tags: [Tag]? = nil)
    {
        // TODO some of this properties could be lazy
        
        self.id = timeEntry.id
        self.description = timeEntry.description.isEmpty ? "No description" : timeEntry.description
        self.projectTaskClient = getProjectTaskClient(from: project, task: task, client: client)
        self.billable = timeEntry.billable
                
        self.start = timeEntry.start
        self.duration = timeEntry.duration >= 0 ? timeEntry.duration : nil
        if let duration = duration {
            self.durationString = duration.formatted
            self.end = timeEntry.start.addingTimeInterval(duration)
        }
        isRunning = duration == nil
        
        descriptionColor = timeEntry.description.isEmpty ? .lightGray : .darkGray
        projectColor = project == nil ? .white : UIColor(hex: project!.color)
        
        self.workspace = workspace
        self.tags = tags
    }
}

// TODO Move this somewhere else for reuse
func getProjectTaskClient(from project:Project?, task: Task?, client: Client?) -> String
{
    var value = ""
    if let project = project { value.append(project.name) }
    if let task = task { value.append(": " + task.name) }
    if let client = client { value.append(" · " + client.name) }
    return value
}

// TODO This is temporal, as in reality we should take settings in cosideration and also inject now date
extension TimeInterval {
    var formatted: String {
        let endingDate = Date()
        let startingDate = endingDate.addingTimeInterval(-self)
        let calendar = Calendar.current

        let componentsNow = calendar.dateComponents([.hour, .minute, .second], from: startingDate, to: endingDate)
        if let hour = componentsNow.hour, let minute = componentsNow.minute, let seconds = componentsNow.second {
            return "\(String(format: "%02d", hour)):\(String(format: "%02d", minute)):\(String(format: "%02d", seconds))"
        } else {
            return "00:00:00"
        }
    }
}

// TODO Move this somewhere else
extension UIColor
{
    convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            fatalError("Color string must be 6 chars long")
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
                
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
