//
//  TimeLogEntities.swift
//  Models
//
//  Created by Ricardo Sánchez Sotres on 20/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Utils

public struct TimeLogEntities
{
    public var timeEntries: Loadable<[TimeEntry.ID: TimeEntry]> = .nothing
    public var workspaces: Loadable<[Workspace.ID: Workspace]> = .nothing
    public var clients: Loadable<[Client.ID: Client]> = .nothing
    public var projects: Loadable<[Project.ID: Project]> = .nothing
    public var tags: Loadable<[Tag.ID: Tag]> = .nothing
    public var tasks: Loadable<[Task.ID: Task]> = .nothing
    
    public init()
    {
        
    }
}
