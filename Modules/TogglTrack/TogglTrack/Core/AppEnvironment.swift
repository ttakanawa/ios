import Foundation
import API
import Repository
import Networking

public struct AppEnvironment
{
    public let api: API
    public let repository: Repository
    
    public init(api: API, repository: Repository)
    {
        self.api = api
        self.repository = repository
    }
    
    public init()
    {
        self.api = API(urlSession: FakeURLSession())
//        self.api = API(urlSession: URLSession(configuration: URLSessionConfiguration.default))
        self.repository = Repository(api: api)
    }
}

extension AppEnvironment
{
    var userAPI: UserAPI
    {
        return api
    }
}
