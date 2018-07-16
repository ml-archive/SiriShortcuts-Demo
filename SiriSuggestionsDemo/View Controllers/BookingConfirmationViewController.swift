//
//  BookingConfirmationViewController
//  SiriSuggestionsDemo
//
//  Created by Andrei Hogea on 11/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import UIKit
import Intents

class BookingConfirmationViewController: UIViewController {
    
    
    var testDrive: TestDrive?
    
    @IBOutlet weak var confimationLabel: UILabel! {
        didSet {
            confimationLabel.numberOfLines = 0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let testDrive = testDrive {
            confimationLabel.text = "Your booking for a test drive in \(testDrive.car.brand) \(testDrive.car.modelName) is now completed"
        } else {
            confimationLabel.text = "Your booking for a test drive is now completed"
        }
    }
    
}
