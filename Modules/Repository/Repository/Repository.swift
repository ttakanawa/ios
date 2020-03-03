//
//  Repository.swift
//  Repository
//
//  Created by Ricardo Sánchez Sotres on 19/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import RxSwift
import Models
import API

public class Repository
{
    private let api: TimelineAPI
    
    public init(api: TimelineAPI)
    {
        self.api = api
    }
    
    public func getWorkspaces() -> Observable<[Workspace]>
    {
        return api.loadWorkspaces()
    }
    
    public func getClients() -> Observable<[Client]>
    {
        return api.loadClients()
    }
    
    public func getTimeEntries() -> Observable<[TimeEntry]>
    {
        return api.loadEntries()
    }
    
    public func getProjects() -> Observable<[Project]>
    {
        return api.loadProjects()
    }
    
    public func getTasks() -> Observable<[Task]>
    {
        return api.loadTasks()
    }
    
    public func getTags() -> Observable<[Tag]>
    {
        return api.loadTags()
    }
}
