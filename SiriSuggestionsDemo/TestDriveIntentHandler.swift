//
//  TestDriveIntentHandler.swift
//  SiriSuggestionsDemo
//
//  Created by Andrei Hogea on 12/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import UIKit
import Intents

class TestDriveIntentHandler: NSObject, TestDriveIntentHandling {
    /// - Tag: confirm_intent
    public func confirm(intent: TestDriveIntent, completion: @escaping (TestDriveIntentResponse) -> Void) {
        
        /*
         The confirm phase provides an opportunity for you to perform any final validation of the intent parameters and to
         verify that any needed services are available. You might confirm that you can communicate with your company’s server
         */
        guard let car = intent.car,
            let modelId = car.identifier,
            let _ = DataManager.shared.findCar(Int(modelId)!) else {
                completion(TestDriveIntentResponse(code: .failure, userActivity: nil))
                return
        }
        
        // Once the intent is validated, indicate that the intent is ready to handle.
        completion(TestDriveIntentResponse(code: .ready, userActivity: nil))
    }
    
    public func handle(intent: TestDriveIntent, completion: @escaping (TestDriveIntentResponse) -> Void) {
        
        guard
            let order = TestDrive(from: intent)
            else {
                completion(TestDriveIntentResponse(code: .failure, userActivity: nil))
                return
        }
        
        //  The handle method is also an appropriate place to handle payment via Apple Pay.
        //  A declined payment is another example of a failure case that could take advantage of a custom response.
        
        TestDriveManager.shared.bookTestDrive(order.car, duration: order.duration)
        
        //  For the success case, we want to indicate a wait time to the user so that they know when their soup order will be ready.
        //  Ths sample uses a hardcoded value, but your implementation could use a time interval returned by your server.
        completion(TestDriveIntentResponse(code: .success, userActivity: nil))
    }
}
