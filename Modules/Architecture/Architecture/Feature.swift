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
    associatedtype Environment
    
    var reducer: Reducer<State, Action, Environment> { get }
    func mainCoordinator(store: Store<State, Action>) -> Coordinator
}

open class BaseFeature<State, Action, Environment>: Feature
{
    public init()
    {
    }
    
    open var reducer: Reducer<State, Action, Environment>
    {
        fatalError()
    }
    
    open func mainCoordinator(store: Store<State, Action>) -> Coordinator
    {
        fatalError()
    }
    
    public func wrap<GlobalState, GlobalAction, GlobalEnvironment>(
        pullback: @escaping (Reducer<State, Action, Environment>) -> Reducer<GlobalState, GlobalAction, GlobalEnvironment>,
        viewStore: @escaping (Store<GlobalState, GlobalAction>) -> Store<State, Action>
    ) -> BaseFeature<GlobalState, GlobalAction, GlobalEnvironment>
    {
        return FeatureWrapper<GlobalState, GlobalAction, GlobalEnvironment, State, Action, Environment>(
            feature: self,
            pullback: pullback,
            viewStore: viewStore
        )
    }
}


public class FeatureWrapper<GlobalState, GlobalAction, GlobalEnvironment, State, Action, Environment>: BaseFeature<GlobalState, GlobalAction, GlobalEnvironment>
{
    private var feature: BaseFeature<State, Action, Environment>
    private var viewStore: (Store<GlobalState, GlobalAction>) -> Store<State, Action>
    private var pullback: (Reducer<State, Action, Environment>) -> Reducer<GlobalState, GlobalAction, GlobalEnvironment>
    
    override public var reducer: Reducer<GlobalState, GlobalAction, GlobalEnvironment> {
        pullback(feature.reducer)
    }
    
    public init(
        feature: BaseFeature<State, Action, Environment>,
        pullback: @escaping (Reducer<State, Action, Environment>) -> Reducer<GlobalState, GlobalAction, GlobalEnvironment>,
        viewStore: @escaping (Store<GlobalState, GlobalAction>) -> Store<State, Action>
    )
    {
        self.feature = feature
        self.viewStore = viewStore
        self.pullback = pullback
    }
        
    override public func mainCoordinator(store: Store<GlobalState, GlobalAction>) -> Coordinator
    {
        feature.mainCoordinator(store: viewStore(store))
    }
}
