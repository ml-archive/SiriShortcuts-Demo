//
//  TestDriveBookingCompleted.swift
//  SiriIntentExtensionUI
//
//  Created by Andrei Hogea on 12/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import Foundation
import UIKit

protocol TestDriveBookingCompletedInput: class {
    func configure(_ testDrive: TestDrive)
}

class TestDriveBookingCompleted: UIView {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var infoLabel: UILabel! {
        didSet {
            infoLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var completedLabel: UILabel! {
        didSet {
            completedLabel.numberOfLines = 0
        }
    }
}

extension TestDriveBookingCompleted: TestDriveBookingCompletedInput {
    func configure(_ testDrive: TestDrive) {
        titleLabel.text = "You have booked a test drive for \(testDrive.car.brand) \(testDrive.car.modelName)"
        infoLabel.text = "The test drive will be \(testDrive.duration) minutes long"
        completedLabel.text = "Order received by showroom"
    }
}
