//
//  IntentViewController.swift
//  SiriIntentExtensionUI
//
//  Created by Andrei Hogea on 11/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    @IBOutlet var overviewView: TestDriveOverview!
    @IBOutlet var completedView: TestDriveBookingCompleted!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        guard
            let intent = interaction.intent as? TestDriveIntent,
            let testDrive = TestDrive(from: intent)
            else {
                completion(false, Set(), .zero)
                return
        }
        
        for view in view.subviews {
            view.removeFromSuperview()
        }
        
        // Different UIs can be displayed depending if the intent is in the confirmation phase or the handle phase.
        var desiredSize = CGSize.zero
        switch interaction.intentHandlingStatus {
        case .ready:
            desiredSize = displayOverview(for: testDrive, from: intent)
        case .success:
            if let response = interaction.intentResponse as? TestDriveIntentResponse {
                desiredSize = displayOrderConfirmation(for: testDrive, from: intent, with: response)
            }
        default:
            break
        }
    
        
        completion(true, parameters, desiredSize)
    }
    
    /// - Returns: Desired size of the view
    private func displayOverview(for testDrive: TestDrive, from intent: TestDriveIntent) -> CGSize {
        overviewView.configure(testDrive)
        
        view.addSubview(overviewView)
        
        let width = self.extensionContext?.hostedViewMaximumAllowedSize.width ?? 320
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: 100))
        overviewView.frame = frame
        
        return frame.size
    }
    
    /// - Returns: Desired size of the view
    private func displayOrderConfirmation(for testDrive: TestDrive, from intent: TestDriveIntent, with response:TestDriveIntentResponse) -> CGSize {
        completedView.configure(testDrive)
        
        view.addSubview(completedView)
        
        let width = self.extensionContext?.hostedViewMaximumAllowedSize.width ?? 320
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: 150))
        completedView.frame = frame
        
        return frame.size
    }
}
