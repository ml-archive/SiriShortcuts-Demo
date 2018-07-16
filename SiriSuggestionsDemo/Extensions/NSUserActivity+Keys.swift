//
//  NSUserActivity+Keys.swift
//  SiriSuggestionsDemo
//
//  Created by Andrei Hogea on 16/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import Foundation

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
        static let catalog = "Show Catalog"
    }
    
}
