//
//  DataManager.swift
//  SiriSuggestionsDemo
//
//  Created by Andrei Hogea on 12/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import Foundation
import Intents

class DataManager {
    
    public static let shared = DataManager()
    
    private static let cars: [Car] = [
        Car(modelId: 1, modelName: "812", brand: "Ferrari", color: "YELLOW", fabricationYear: 2018),
        Car(modelId: 2, modelName: "California", brand: "Ferrari", color: "RED", fabricationYear: 2013),
        Car(modelId: 3, modelName: "California", brand: "Ferrari", color: "RED", fabricationYear: 2010),
        Car(modelId: 4, modelName: "488", brand: "Ferrari", color: "RED", fabricationYear: 2017)
    ]
    
    public func getCarsInCatalog() -> [Car] {
        return DataManager.cars
    }
    
    public func findCar(_ id: Int) -> Car? {
        return DataManager.cars.first(where: {$0.modelId == id})
    }
}
