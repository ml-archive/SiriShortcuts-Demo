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
