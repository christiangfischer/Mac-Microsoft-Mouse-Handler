//
//  WindowHandler.swift
//  KeyPressed
//
//  Created by Christian Fischer on 18.06.22.
//

import Foundation
import AppKit

class WindowHandler {
    // private var win = NSRunningApplication()
    
    init() {
        // every time we click the mouse button, we must check the current application in foreground
        //self.win = NSWorkspace.shared.frontmostApplication!
    }
    
    func getFrontmostApplication() -> NSRunningApplication {
        return NSWorkspace.shared.frontmostApplication!
    }
    
    func getBundleId(app: NSRunningApplication) -> String {
        return app.bundleIdentifier ?? " "
    }
    
    func getApplicationPid(app: NSRunningApplication) -> pid_t {
        return app.processIdentifier
    }
}
