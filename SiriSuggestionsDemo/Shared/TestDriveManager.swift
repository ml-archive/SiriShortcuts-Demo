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
    

    private func donateInteraction(for testDrive: TestDrive) {
        let interaction = INInteraction(intent: testDrive.intent, response: nil)
        interaction.donate { (error) in
            if error != nil {
                if let error = error {
                    print("Interaction donation failed")
                    print(error.localizedDescription)
                }
            } else {
                print("Successfully donated interaction")
            }
        }
    }
    
    @discardableResult
    func bookTestDrive(_ car: Car, duration: Int) -> TestDrive {
        //Create TestDrive instance from booking data
        let testDrive = TestDrive(car: car, duration: duration)
        
        //Here book test drive logic
        
        // Donate an interaction to the system.
        donateInteraction(for: testDrive)
        
        return testDrive
    }
    
}
