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
    // These mock the DB
    private var workspaces = [Workspace]()
    private var clients = [Client]()
    private var timeEntries = [TimeEntry]()
    private var projects = [Project]()
    private var tasks = [Task]()
    private var tags = [Tag]()
    // ------------------------
    
    private let api: TimelineAPI
    
    public init(api: TimelineAPI)
    {
        self.api = api
    }
    
    public func getWorkspaces() -> Observable<[Workspace]>
    {
        if workspaces.isEmpty {
            return api.loadWorkspaces()
                .do(onNext: { self.workspaces = $0 })
        }
        
        return Observable.just(workspaces)
    }
    
    public func getClients() -> Observable<[Client]>
    {
        if clients.isEmpty {
            return api.loadClients()
                .do(onNext: { self.clients = $0 })
        }
        
        return Observable.just(clients)
    }
    
    public func getTimeEntries() -> Observable<[TimeEntry]>
    {
        if timeEntries.isEmpty {
            return api.loadEntries()
                .do(onNext: { self.timeEntries = $0 })
        }
        
        return Observable.just(timeEntries)
    }
    
    public func getProjects() -> Observable<[Project]>
    {
        if projects.isEmpty {
            return api.loadProjects()
                .do(onNext: { self.projects = $0 })
        }
        
        return Observable.just(projects)
    }
    
    public func getTasks() -> Observable<[Task]>
    {
        if tasks.isEmpty {
            return api.loadTasks()
                .do(onNext: { self.tasks = $0 })
        }
        
        return Observable.just(tasks)
    }
    
    public func getTags() -> Observable<[Tag]>
    {
        if tags.isEmpty {
            return api.loadTags()
                .do(onNext: { self.tags = $0 })
        }
        
        return Observable.just(tags)
    }
    
    public func addTimeEntry(timeEntry: TimeEntry) -> Observable<Void>
    {
        timeEntries.append(timeEntry)
        return Observable.just(())
    }
}
