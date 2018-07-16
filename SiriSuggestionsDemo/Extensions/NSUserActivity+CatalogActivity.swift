//
//  NSUserActivity+CatalogActivity.swift
//  SiriSuggestionsDemo
//
//  Created by Andrei Hogea on 12/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import Foundation
import CoreSpotlight
import UIKit

extension NSUserActivity {
    static var catalogActivity: NSUserActivity {
        let activity = NSUserActivity(activityType: NSUserActivity.ActivityTypes.catalog)
        activity.title = NSUserActivity.ActivityTitles.catalog
        activity.userInfo = [:]
        activity.requiredUserInfoKeys = []
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        activity.persistentIdentifier = NSUserActivityPersistentIdentifier(NSUserActivity.ActivityKeys.catalog)
        activity.suggestedInvocationPhrase = NSUserActivity.InvocationPhrase.catalog
        
        #if os(iOS)
        let attributes = CSSearchableItemAttributeSet(itemContentType: NSUserActivity.ActivityTypes.catalog)
        attributes.keywords = NSUserActivity.SearchableKeywords.catalog
        attributes.displayName = NSUserActivity.SearchableName.catalog
        attributes.contentDescription = NSUserActivity.SearchableDescription.catalog
        
        activity.contentAttributeSet = attributes
        #endif
        
        return activity
    }

}
