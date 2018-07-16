//
//  AppDelegate.swift
//  SiriSuggestionsDemo
//
//  Created by Andrei Hogea on 11/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Needed for Shortcuts
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
       print(userActivity)
        if let intent = userActivity.interaction?.intent as? TestDriveIntent {
            //handle intent
            handle(intent)
            return true
        } else if userActivity.activityType == NSUserActivity.ActivityTypes.catalog {
            //handle activity
            return true
        }
        return false
    }
    
    private func handle(_ intent: TestDriveIntent) {
        let handler = TestDriveIntentHandler()
        handler.handle(intent: intent) { (response) in

            if response.code != .success {
                print("failed handling intent")
            } else {
                guard let window = self.window,
                    let rootViewController = window.rootViewController as? UINavigationController,
                    let vc = rootViewController.viewControllers.first as? CatalogViewController else {
                        return
                }
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                let confirmationVC = storyboard.instantiateViewController(withIdentifier: "BookingConfirmationViewController") as! BookingConfirmationViewController
                confirmationVC.testDrive = TestDrive(from: intent)
                vc.navigationController?.pushViewController(confirmationVC, animated: true)
            }
        }
    }
}

