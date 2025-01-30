//
//  ApplicationControl.swift
//  Microsoft Mouse Handler
//
//  Created by Christian Fischer on 26.01.25.
//

import Foundation
import AppKit

class Application {
    func performHistoryAction(menuItem: AXUIElement) {
        AXUIElementPerformAction(menuItem, kAXPressAction as CFString)
    }
    
    func getWindowElement(appName: String) throws -> AXUIElement {
        guard let app = NSWorkspace.shared.runningApplications.first(where: { $0.bundleIdentifier == appName }) else {
            throw ControlErrors.applicationNotRunning
        }
        
        return AXUIElementCreateApplication(app.processIdentifier)
    }
    
    enum ControlErrors: Error, LocalizedError {
        case applicationNotRunning
        case failedToAccessMenuBar
        case failedToAccessMenuBarItems
        case historyMenuNotFound
        case historyMenuItemNotFound
        case menuItemNotFound(String)
        case failedToPerformAction
        
        var errorDescription: String? {
            switch self {
            case .applicationNotRunning:
                return "Application is not running or not in foreground"
            case .failedToAccessMenuBar:
                return "Error accessing menu bar"
            case .failedToAccessMenuBarItems:
                return "Error accessing menu items"
            case .historyMenuNotFound:
                return "History menu not found"
            case .historyMenuItemNotFound:
                return "History menu item not found"
            case .menuItemNotFound(let string):
                return "Menu item \"\(string)\" not found"
            case .failedToPerformAction:
                return "Failed to perform action"
            }
        }
    }
}
