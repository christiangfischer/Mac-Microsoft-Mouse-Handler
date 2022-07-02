//
//  WindowHandler.swift
//  KeyPressed
//
//  Created by Christian Fischer on 18.06.22.
//

import Foundation
import AppKit

class WindowHandler {
    private var win = NSRunningApplication()
    
    init() {
        // every time we click the mouse button, we must check the current application in foreground
        self.win = NSWorkspace.shared.frontmostApplication!
    }
    
    func safariIsForeground() -> Bool {
        var b: Bool = false
        
        if self.win.bundleIdentifier == "com.apple.Safari" {
            b = true
        }
        
        return b
    }
    
    func getSafariPid() -> pid_t {
        return self.win.processIdentifier
    }
}
