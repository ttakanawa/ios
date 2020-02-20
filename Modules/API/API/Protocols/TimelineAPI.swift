//
//  TimelineAPI.swift
//  API
//
//  Created by Ricardo Sánchez Sotres on 20/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Models
import RxSwift

public protocol TimelineAPI
{
    func loadEntries() -> Observable<[TimeEntry]>
    func loadWorkspaces() -> Observable<[Workspace]>
    func loadClients() -> Observable<[Client]>
    func loadProjects() -> Observable<[Project]>
    func loadTags() -> Observable<[Tag]>
    func loadTasks() -> Observable<[Task]>
}
