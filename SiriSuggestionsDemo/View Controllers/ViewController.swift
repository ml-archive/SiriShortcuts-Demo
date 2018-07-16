//
//  ViewController.swift
//  SiriSuggestionsDemo
//
//  Created by Andrei Hogea on 11/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import UIKit
import Intents
import CoreSpotlight

class ViewController: UIViewController {
    
    private var cars: [Car] = TestDriveManager.shared.getCarsInCatalog()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = .clear
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorColor = .darkGray
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            tableView.tableHeaderView = UIView(frame: CGRect.zero)
            tableView.tableFooterView = UIView(frame: CGRect.zero)
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(UINib.init(nibName: "\(CarCell.self)", bundle: Bundle.main), forCellReuseIdentifier: "CarCell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        makeCatalogActivity()
        requestSiriAuthorization()
    }

    //if user hasn't already allowed Siri permisions, we request the user to authorize Siri
    private func requestSiriAuthorization() {
        guard INPreferences.siriAuthorizationStatus() != .authorized else { return }
                
        INPreferences.requestSiriAuthorization { (status) in
            switch status {
            case .authorized, .notDetermined, .restricted:
                self.makeCatalogActivity()
            case .denied:
                self.allowSiriAlert()
            }
        }
    }
    
    private func allowSiriAlert() {
        let alert = UIAlertController(title: "Siri permision needed", message: nil, preferredStyle: .alert)
        let allow = UIAlertAction(title: "Allow", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            } else {
                print("can't open path")
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(allow)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Donate Activity
    
    @objc private func orderSoup() {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let vc = storyboard.instantiateViewController(withIdentifier: "DonatedShortcutViewController") as! DonatedShortcutViewController
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func makeCatalogActivity() {
        userActivity = NSUserActivity.catalogActivity
    }
    
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CarCell.self)", for: indexPath) as! CarCell
        cell.configure(cars[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
