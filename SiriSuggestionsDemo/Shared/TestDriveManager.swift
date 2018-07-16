//
//  TestDriveManager.swift
//  SiriSuggestionsDemo
//
//  Created by Andrei Hogea on 12/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import Foundation
import Intents

class TestDriveManager {
    
    public static let shared = TestDriveManager()
    
    @discardableResult
    func bookTestDrive(_ car: Car, duration: Int) -> TestDrive {
        //Create TestDrive instance from booking data
        let testDrive = TestDrive(car: car, duration: duration)
        
        //Here book test drive logic
        
        
        return testDrive
    }
    
}
