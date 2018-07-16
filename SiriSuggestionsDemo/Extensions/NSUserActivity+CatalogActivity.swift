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
    
    struct ActivityKeys {
        static let catalog = "catalogActivity"
    }
    
    struct ActivityTypes {
        static let catalog = "com.nodes.siriSugestions.demo.catalogActivity"
    }
    
    struct ActivityTitles {
        static let catalog = "Car Showroom Catalog"
    }
    
    struct SearchableKeywords {
        static let catalog = ["CAR", "SHOWROOM", "CATALOG", "CARS"]
    }
    
    struct SearchableName {
        static let catalog = "Car Showroom Catalog"
    }
    
    struct SearchableDescription {
        static let catalog = "Find the best cars for your testdrive"
    }
    
    struct InvocationPhrase {
        static let catalog = "Amazing Catalog"
    }
}

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
        //attributes.thumbnailData = #imageLiteral(resourceName: "tomato").pngData() // Used as an icon in Search.
        attributes.keywords = NSUserActivity.SearchableKeywords.catalog
        attributes.displayName = NSUserActivity.SearchableName.catalog
        attributes.contentDescription = NSUserActivity.SearchableDescription.catalog
        
        activity.contentAttributeSet = attributes
        #endif
        
        return activity
    }

}
