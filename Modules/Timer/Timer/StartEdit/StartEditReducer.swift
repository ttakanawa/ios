//
//  StartEditReducer.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 28/02/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture
import Models
import RxSwift
import Repository

let startEditReducer = Reducer<StartEditState, StartEditAction, Repository> { state, action, repository in
    
    switch action {
        
    case let .descriptionEntered(description):
        state.description = description
        
    case .startTapped:
        fatalError("Handled in common reducer")

    }
    
    return .empty
}
