//
//  Car.swift
//  SiriSuggestionsDemo
//
//  Created by Andrei Hogea on 12/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import Foundation

struct Car: Codable, Hashable {
    
    let modelName: String
    let brand: String
    let color: String
    let fabricationYear: Int
    
    init(modelName: String, brand: String, color: String, fabricationYear: Int) {
        self.modelName = modelName
        self.brand = brand
        self.color = color
        self.fabricationYear = fabricationYear
    }
}
