//
//  ViewController.swift
//  SiriSuggestionsDemo
//
//  Created by Andrei Hogea on 11/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import UIKit
import IntentsUI
import CoreSpotlight

class CatalogViewController: UIViewController {
    
    private lazy var voiceShortcutManager = VoiceShortcutsManager.init()
    private var cars: [Car] = DataManager.shared.getCarsInCatalog()

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
        
        title = "Catalog"
        
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
    
    private func makeCatalogActivity() {
        userActivity = NSUserActivity.catalogActivity
    }
    
    // MARK: - Update Voice Shortcuts
    
    func updateVoiceShortcuts() {
        voiceShortcutManager.updateVoiceShortcuts(completion: nil)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension CatalogViewController: UITableViewDataSource {
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

extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let car = cars[indexPath.row]
        
        let testDrive = TestDriveManager.shared.bookTestDrive(car, duration: 60)
        
        //is action already has a shortcut, update shortcut else create shortcut
        if let shortcut = voiceShortcutManager.voiceShortcut(for: testDrive) {
            let editVoiceShortcutViewController = INUIEditVoiceShortcutViewController(voiceShortcut: shortcut)
            editVoiceShortcutViewController.delegate = self
            present(editVoiceShortcutViewController, animated: true, completion: nil)
        } else if let shortcut = INShortcut(intent: testDrive.intent) {
            let addVoiceShortcutVC = INUIAddVoiceShortcutViewController(shortcut: shortcut)
            addVoiceShortcutVC.delegate = self
            present(addVoiceShortcutVC, animated: true, completion: nil)
        }
        
    }
}

// MARK: - INUIAddVoiceShortcutViewControllerDelegate

extension CatalogViewController: INUIAddVoiceShortcutViewControllerDelegate {
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController,
                                        didFinishWith voiceShortcut: INVoiceShortcut?,
                                        error: Error?) {
        if let error = error {
            print("error adding voice shortcut:\(error.localizedDescription)")
            return
        }
        updateVoiceShortcuts()
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - INUIEditVoiceShortcutViewControllerDelegate

extension CatalogViewController: INUIEditVoiceShortcutViewControllerDelegate {
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController,
                                         didUpdate voiceShortcut: INVoiceShortcut?,
                                         error: Error?) {
        if let error = error {
            print("error adding voice shortcut:\(error.localizedDescription)")
            return
        }
        updateVoiceShortcuts()
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController,
                                         didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        updateVoiceShortcuts()
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        dismiss(animated: true, completion: nil)
    }
}
