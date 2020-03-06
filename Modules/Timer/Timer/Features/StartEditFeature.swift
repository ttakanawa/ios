//
//  StartEditFeature.swift
//  Timer
//
//  Created by Ricardo Sánchez Sotres on 06/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Architecture

class StartEditFeature: BaseFeature<StartEditState, StartEditAction>
{
    override func mainCoordinator(store: Store<StartEditState, StartEditAction>) -> Coordinator {
        return StartEditCoordinator(store: store)
    }
}

