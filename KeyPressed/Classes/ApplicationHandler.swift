//
//  ApplicationHandler.swift
//  Microsoft Mouse Handler
//
//  Created by Christian Fischer on 16.07.22.
//

import Foundation
import AppKit

// call from window handler with app and mouse button
func handleApplicationClicks(app: NSRunningApplication, mouseButton: Int) {
    if mouseButton == 3 || mouseButton == 4 {
        if app.bundleIdentifier == "com.apple.Safari" {
            handleSafariClicks(mouseButton: mouseButton)
        } else if app.bundleIdentifier == "com.apple.finder" {
            handleFinderClicks(mouseButton: mouseButton)
        }
    }
}

private func handleSafariClicks(mouseButton: Int) {
    var saf = Safari()
    saf.buttonElement = saf.getButtonForMouseClick(mouseButton: mouseButton)
    saf.performHistoryAction(menuItem: saf.buttonElement!)
}

private func handleFinderClicks(mouseButton: Int) {
    var fin = Finder()
    fin.buttonElement = fin.getButtonForMouseClick(mouseButton: mouseButton)
    fin.performHistoryAction(menuItem: fin.buttonElement!)
}
