//
//  API.swift
//  API
//
//  Created by Ricardo Sánchez Sotres on 15/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift
import Networking
import Models

public class API
{
    #if DEBUG
    private let baseURL: String = "https://mobile.toggl.com/api/v9/"
    #else
    private let baseURL: String = "https://mobile.toggl.com/api/v9/"
    #endif
    
    private let userAgent: String = "AppleWatchApp"
    private var appVersion: String = ""
    private var headers: [String : String]
    
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
    
    public func setAuth(token: String?)
    {
        guard let token = token else {
            updateAuthHeaders(with: nil)
            return
        }
        let loginData = "\(token):api_token".data(using: String.Encoding.utf8)!
        updateAuthHeaders(with: loginData)
    }
    
    public func loginUser(email: String, password: String) -> Observable<User>
    {
        let loginData = "\(email):\(password)".data(using: String.Encoding.utf8)!
        updateAuthHeaders(with: loginData)

        let endpoint: Endpoint<User> = createEntityEndpoint(path: "me")
        return urlSession.load(endpoint)
    }
    
    public func loadUser() -> Observable<User>
    {
        let endpoint: Endpoint<User> = createEntityEndpoint(path: "me")
        return urlSession.load(endpoint)
    }
        
    private func updateAuthHeaders(with loginData: Data?)
    {
        guard let loginData = loginData else {
            headers["Authorization"] = nil
            return
        }
        
        let base64LoginString = loginData.base64EncodedString()
        let authHeader = "Basic \(base64LoginString)"
        headers["Authorization"] = authHeader
    }
    
    private func createEntityEndpoint<T>(path: String) -> Endpoint<T> where T: Decodable
    {
        return Endpoint<T>(
            json: .get,
            url: URL(string: baseURL + path)!,
            headers: headers,
            decoder: jsonDecoder
        )
    }
}
