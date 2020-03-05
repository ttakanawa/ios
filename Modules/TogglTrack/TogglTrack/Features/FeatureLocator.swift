//
//  FeatureLocator.swift
//  TogglTrack
//
//  Created by Ricardo Sánchez Sotres on 05/03/2020.
//  Copyright © 2020 Ricardo Sánchez Sotres. All rights reserved.
//

import Foundation
import Onboarding
import Architecture
import API

class FeatureLocator
{
    typealias AppFeature = BaseFeature<AppState, AppAction, AppEnvironment>
    private static var features = [String: AppFeature]()
    
    public static func feature(for id: String) -> AppFeature
    {
        if let feature = features[id] {
            return feature
        }
        
        let feature = locateFeature(for: id)
        features[id] = feature
        return feature
    }
    
    private static func locateFeature(for id: String) -> AppFeature
    {
        switch id {
        
        case "onboarding":
            
            return FeatureWrapper(
                feature: OnboardingFeature(),
                pullback: { $0.pullback(
                    state: \AppState.onboardingState,
                    action: \AppAction.onboarding,
                    environment: \AppEnvironment.userAPI
                )},
                viewStore: { $0.view(
                    state: { $0.onboardingState },
                    action: { AppAction.onboarding($0) }
                )}
            )
            
        default:
            fatalError()
        }
    }
}
