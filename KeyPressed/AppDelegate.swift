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
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        createStatusBarItem()
        
        if keyPress() {
            print("start monitoring")
        }
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
}

