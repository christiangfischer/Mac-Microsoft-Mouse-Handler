//
//  StatusBarHandler.swift
//  KeyPressed
//
//  Created by Christian Fischer on 30.06.22.
//

import Foundation
import Cocoa

extension AppDelegate {
    
    func createStatusBarItem() {
        let sBar = NSStatusBar.system
        
        // create status bar item in system status bar
        sBarItem = sBar.statusItem(withLength: NSStatusItem.squareLength)
        sBarItem.button?.image = NSImage(systemSymbolName: "computermouse.fill", accessibilityDescription: "")
        
        let sBarMenu = NSMenu(title: NSLocalizedString("option_menutitle", comment: "Title of menu"))
        
        // assign menu to status bar item
        sBarItem.menu = sBarMenu
        
        let enableDisableMenuItem = NSMenuItem(title: NSLocalizedString("enable_button", comment: "menu item indicating if handler is enabled"), action: #selector(toggleAdvancedMouseHandlingObjc), keyEquivalent: "e")
        onOffMenuItem = enableDisableMenuItem
        onOffMenuItem.state = NSControl.StateValue.on
        
        sBarMenu.addItem(onOffMenuItem)
        sBarMenu.addItem(withTitle: NSLocalizedString("quit_button", comment: "Terminate the application"), action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
    }
    
    @objc func toggleAdvancedMouseHandlingObjc() {
        if sHandler.isAdvancedMouseHandlingEnabled() {
            ev?.stop()
            sHandler.disableAdvancedMouseHandling()
        } else {
            ev?.start()
            sHandler.enableAdvancedMouseHandling()
        }
        
        toggleStatusBarImage(useFill: sHandler.isAdvancedMouseHandlingEnabled())
        onOffMenuItem.state = sHandler.isAdvancedMouseHandlingEnabled() ? NSControl.StateValue.on : NSControl.StateValue.off
    }
    
    private func toggleStatusBarImage(useFill: Bool) {
        if let b = sBarItem.button {
            b.image = NSImage(systemSymbolName: useFill ? "computermouse.fill" : "computermouse", accessibilityDescription: "")
        }
    }
}
