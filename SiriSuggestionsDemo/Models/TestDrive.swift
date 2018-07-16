//
//  TestDrive.swift
//  SiriSuggestionsDemo
//
//  Created by Andrei Hogea on 12/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import Foundation
import Intents

public struct TestDrive: Codable, Hashable {
    
    let duration: Int
    let car: Car
    
    init(car: Car, duration: Int) {
        self.car = car
        self.duration = duration
    }
}

extension TestDrive {
    public var intent: TestDriveIntent {
        let intent = TestDriveIntent()
        intent.car = INObject(identifier: car.modelId.description, display: car.brand + " " + car.modelName)
        intent.duration = duration as NSNumber
        
        let options: [String: String] = ["fabricationYear": car.fabricationYear.description]
        var intentOptions: [INObject] = []
        options.keys.forEach { (key) in
            let value = options[key]
            intentOptions.append(INObject(identifier: key, display: value!))
        }
        
        intent.options = intentOptions
        intent.suggestedInvocationPhrase = "Book a test drive for \(car.brand) \(car.modelName)"
        
        return intent
    }
    
    public init?(from intent: TestDriveIntent) {
        guard let modelId = intent.car?.identifier,
            let car = DataManager.shared.findCar(Int(modelId)!),
            let duration = intent.duration
            else { return nil }
        
        self.init(car: car, duration: Int(truncating: duration))
    }
}
