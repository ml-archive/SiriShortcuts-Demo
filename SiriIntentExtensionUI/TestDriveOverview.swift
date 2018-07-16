//
//  TestDriveOverview.swift
//  SiriIntentExtensionUI
//
//  Created by Andrei Hogea on 12/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import Foundation
import UIKit

protocol TestDriveOverviewInput: class {
    func configure(_ testDrive: TestDrive)
}

class TestDriveOverview: UIView {
    
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
    
}

extension TestDriveOverview: TestDriveOverviewInput {
    func configure(_ testDrive: TestDrive) {
        titleLabel.text = "Book a test drive for \(testDrive.car.brand) \(testDrive.car.modelName) ?"
        infoLabel.text = "The test drive will be \(testDrive.duration) minutes long"
    }
}
