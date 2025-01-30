//
//  AccessibilityHandler.swift
//  Microsoft Mouse Handler
//
//  Created by Christian Fischer on 03.07.22.
//

import Foundation
import Cocoa

func checkAccessibilityAndPromptAlert() -> Bool {
    var success: Bool = false
    if !isAccessibilityEnabled() {
        promptAccessibilityAlert()
        promptAccssibilityGrantRequest()
        
        success = false
    } else {
        success = true
    }
    
    return success
}

private func isAccessibilityEnabled() -> Bool {
    let trusted = AXIsProcessTrusted()
    return trusted
}

private func promptAccessibilityAlert() {
    let alert = NSAlert()
    alert.messageText = NSLocalizedString("accessibility_grant_message", comment: "tell user to grant privileges")
    alert.runModal()
}

private func promptAccssibilityGrantRequest() {
    let checkOptPrompt = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString
    // will prompt if accessibility is not granted
    // no need to evaluate the return value
    _ = AXIsProcessTrustedWithOptions([checkOptPrompt: true] as CFDictionary?)
}
