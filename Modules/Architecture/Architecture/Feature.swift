//
//  Feature.swift
//  Architecture
//
//  Created by Ricardo Sánchez Sotres on 05/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import UIKit

public protocol Feature
{
    associatedtype State
    associatedtype Action
    
    func mainCoordinator(store: Store<State, Action>) -> Coordinator
}

open class BaseFeature<State, Action>: Feature
{
    public init()
    {
    }
    
    open func mainCoordinator(store: Store<State, Action>) -> Coordinator
    {
        fatalError()
    }
    
    public func view<GlobalState, GlobalAction>(
        viewStore: @escaping (Store<GlobalState, GlobalAction>) -> Store<State, Action>
    ) -> BaseFeature<GlobalState, GlobalAction>
    {
        return FeatureWrapper<GlobalState, GlobalAction, State, Action>(
            feature: self,
            viewStore: viewStore
        )
    }
}


public class FeatureWrapper<GlobalState, GlobalAction, State, Action>: BaseFeature<GlobalState, GlobalAction>
{
    private var feature: BaseFeature<State, Action>
    private var viewStore: (Store<GlobalState, GlobalAction>) -> Store<State, Action>
        
    public init(
        feature: BaseFeature<State, Action>,
        viewStore: @escaping (Store<GlobalState, GlobalAction>) -> Store<State, Action>
    )
    {
        self.feature = feature
        self.viewStore = viewStore
    }
        
    override public func mainCoordinator(store: Store<GlobalState, GlobalAction>) -> Coordinator
    {
        feature.mainCoordinator(store: viewStore(store))
    }
}
