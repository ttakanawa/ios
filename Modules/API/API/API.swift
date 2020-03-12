import Foundation
import RxSwift
import Networking
import Models

public class API {
    
    #if DEBUG
    private let baseURL: String = "https://mobile.toggl.com/api/v9/"
    #else
    private let baseURL: String = "https://mobile.toggl.com/api/v9/"
    #endif
    
    private let userAgent: String = "AppleWatchApp"
    private var appVersion: String = ""
    private var headers: [String: String]
    
    private let urlSession: URLSessionProtocol
    private var jsonDecoder: JSONDecoder
    
    public init(urlSession: URLSessionProtocol)
    {
        self.urlSession = urlSession
        
        jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            appVersion = version
        }
        
        headers = ["User-Agent": userAgent + appVersion]
    }
      
    private func updateAuthHeaders(with loginData: Data?) {
        guard let loginData = loginData else {
            headers["Authorization"] = nil
            return
        }
        
        let base64LoginString = loginData.base64EncodedString()
        let authHeader = "Basic \(base64LoginString)"
        headers["Authorization"] = authHeader
    }
    
    private func createEntityEndpoint<T>(path: String) -> Endpoint<T> where T: Decodable {
        return Endpoint<T>(
            json: .get,
            url: URL(string: baseURL + path)!,
            headers: headers,
            decoder: jsonDecoder
        )
    }
        
    private func createEntitiesEndpoint<T>(path: String) -> Endpoint<[T]> where T: Decodable {
        return Endpoint<[T]>(
            json: .get,
            url: URL(string: baseURL + path)!,
            headers: headers,
            decoder: jsonDecoder
        )
    }
}

extension API: UserAPI {
    
    public func loginUser(email: String, password: String) -> Observable<User> {
        let loginData = "\(email):\(password)".data(using: String.Encoding.utf8)!
        updateAuthHeaders(with: loginData)

        let endpoint: Endpoint<User> = createEntityEndpoint(path: "me")
        return urlSession.load(endpoint)
    }
    
    public func setAuth(token: String?) {
        guard let token = token else {
            updateAuthHeaders(with: nil)
            return
        }
        let loginData = "\(token):api_token".data(using: String.Encoding.utf8)!
        updateAuthHeaders(with: loginData)
    }
      
}

extension API: TimelineAPI {
    
    public func loadEntries() -> Single<[TimeEntry]> {
        let endpoint: Endpoint<[TimeEntry]> = createEntitiesEndpoint(path: "me/time_entries")
        return urlSession.load(endpoint).asSingle()
    }
    
    public func loadWorkspaces() -> Single<[Workspace]> {
        let endpoint: Endpoint<[Workspace]> = createEntitiesEndpoint(path: "me/workspaces")
        return urlSession.load(endpoint).asSingle()
    }
    
    public func loadClients() -> Single<[Client]> {
        let endpoint: Endpoint<[Client]> = createEntitiesEndpoint(path: "me/clients")
        return urlSession.load(endpoint).asSingle()
    }
    
    public func loadProjects() -> Single<[Project]> {
        let endpoint: Endpoint<[Project]> = createEntitiesEndpoint(path: "me/projects")
        return urlSession.load(endpoint).asSingle()
    }
    
    public func loadTags() -> Single<[Tag]> {
        let endpoint: Endpoint<[Tag]> = createEntitiesEndpoint(path: "me/tags")
        return urlSession.load(endpoint).asSingle()
    }
    
    public func loadTasks() -> Single<[Task]> {
        let endpoint: Endpoint<[Task]> = createEntitiesEndpoint(path: "me/tasks")
        return urlSession.load(endpoint).asSingle()
    }
}
