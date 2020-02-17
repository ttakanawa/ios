//
//  URLSessionExtension.swift
//  Networking
//
//  Created by Ricardo Sánchez Sotres on 15/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift

public struct NoTokenError: Error
{
    public init() { }
}

public enum NetworkingError: Error
{
    case noData
    case wrongStatus(Int, HTTPURLResponse?)
    case unknown
}


public protocol URLSessionProtocol
{
    func load<A>(_ endpoint: Endpoint<A>) -> Observable<A>
}

extension URLSession: URLSessionProtocol
{
    public func load<A>(_ endpoint: Endpoint<A>) -> Observable<A>
    {
        return Observable.create { observer in
            
            let task = self.dataTask(with: endpoint.request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    observer.onError(NetworkingError.noData)
                    return
                }
                
                if 200 ..< 300 ~= response.statusCode {
                    
                    guard let data = data else {
                        observer.onError(NetworkingError.noData)
                        return
                    }
                    
                    do {
                        let result = try endpoint.parse(data)
                        observer.onNext(result)
                    } catch {
                        observer.onError(error)
                    }
                    
                    
                } else {
                    observer.onError(NetworkingError.wrongStatus(response.statusCode, response))
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
