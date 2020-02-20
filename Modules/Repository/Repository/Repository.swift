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
    
    public func getTimeEntries() -> Observable<[TimeEntry]>
    {
        return api.loadEntries()
    }
}
