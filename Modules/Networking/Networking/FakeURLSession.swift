import Foundation
import RxSwift
import Assets

public class FakeURLSession: URLSessionProtocol {
    
    var requests: [String: String]  = [
        "time_entries": "timeentries",
        "workspaces": "workspaces",
        "projects": "projects",
        "clients": "clients",
        "tags": "tags",
        "tasks": "tasks",
        "me": "me"
    ]
    
    public init() {}
    
    public func load<A>(_ endpoint: Endpoint<A>) -> Observable<A> {
        
        let bundle = Assets.bundle
        guard let resource = requests[endpoint.request.url!.lastPathComponent],
            let path = bundle.path(forResource: resource, ofType: "txt") else {
                return Observable.error(NetworkingError.unknown)
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let result = try endpoint.parse(data)
            return Observable.just(result)
        } catch {
            return Observable.error(error)
        }
    }
}
