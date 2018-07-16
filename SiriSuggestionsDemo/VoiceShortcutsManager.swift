//
//  VoiceShortcutsManager.swift
//  SiriSuggestionsDemo
//
//  Created by Andrei Hogea on 12/07/2018.
//  Copyright © 2018 Andrei Hogea. All rights reserved.
//

import Foundation
import Intents

public class VoiceShortcutsManager {
    
    private var voiceShortcuts: [INVoiceShortcut] = []
    
    public init() {
        updateVoiceShortcuts(completion: nil)
    }
    
    public func voiceShortcut(for order: TestDrive) -> INVoiceShortcut? {
        let voiceShorcut = voiceShortcuts.first { (voiceShortcut) -> Bool in
            guard let intent = voiceShortcut.__shortcut.intent as? TestDriveIntent,
                let testDrive = TestDrive(from: intent) else {
                    return false
            }
            return order == testDrive
        }
        return voiceShorcut
    }
    
    public func updateVoiceShortcuts(completion: (() -> Void)?) {
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { (voiceShortcutsFromCenter, error) in
            guard let voiceShortcutsFromCenter = voiceShortcutsFromCenter else {
                if let error = error {
                    print("Failed to fetch voice shortcuts with error: \(error.localizedDescription)")
                }
                return
            }
            self.voiceShortcuts = voiceShortcutsFromCenter
            if let completion = completion {
                completion()
            }
        }
    }
}
