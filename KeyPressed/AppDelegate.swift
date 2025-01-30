//
//  AppDelegate.swift
//  KeyPressed
//
//  Created by Christian Fischer on 13.06.22.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var sBarItem: NSStatusItem!
    var onOffMenuItem: NSMenuItem!
    var sHandler = StatusHandler(status: true)
    var ev: EventMonitor?
    var safariHandler: Safari = Safari()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if checkAccessibilityAndPromptAlert() {
            createStatusBarItem()
            keyPress()
        } else {
            NSApp.terminate(self)
        }
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
}

