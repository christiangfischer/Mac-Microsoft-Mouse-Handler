//
//  MouseClickHandler.swift
//  KeyPressed
//
//  Created by Christian Fischer on 30.06.22.
//

import Foundation
import Cocoa

extension AppDelegate {
    func keyPress() -> Bool {
        var backButtonElement: AXUIElement?
        var forwardButtonElement: AXUIElement?
        
        // check if handling is enabled
        if sHandler.isAdvancedMouseHandlingEnabled() {
            NSEvent.addGlobalMonitorForEvents(matching: .otherMouseDown) { event in
                if self.sHandler.isAdvancedMouseHandlingEnabled() {
                    // create new object of WindowHandler
                    let win = WindowHandler()
                    
                    if win.safariIsForeground() {
                        // mouse button 3: backwards
                        // mouse button 4: forwards
                        
                        // check if we already know the AXUIElements
                        if (backButtonElement == nil) || (forwardButtonElement == nil) {
                            backButtonElement = getBackwardElement()
                            forwardButtonElement = getForwardElement()
                        }
                        
                        if event.buttonNumber == 3 {
                            performHistoryAction(menuItem: backButtonElement!)
                        } else if event.buttonNumber == 4 {
                            performHistoryAction(menuItem: forwardButtonElement!)
                        }
                    }
                } else {
                    // maybe a modular handling is better
                    // -> startMonitor(); stopMonitor()
                    // NSEvent.removeMonitor(event)
                    backButtonElement = nil
                    forwardButtonElement = nil
                }
            }
        }
        
        return true
    }
}

func performHistoryAction(menuItem: AXUIElement) {
    AXUIElementPerformAction(menuItem, kAXPressAction as CFString)
}

func getBackwardElement() -> AXUIElement {
    let backMenuItem = getHistoryMenuItemsElement()[2]
    return backMenuItem
}

func getForwardElement() -> AXUIElement {
    let forwardMenuItem = getHistoryMenuItemsElement()[3]
    return forwardMenuItem
}

func getHistoryMenuItemsElement() -> [AXUIElement] {
    guard let safari = NSWorkspace.shared.runningApplications.first(where: { $0.bundleIdentifier == "com.apple.Safari" }) else {
        fatalError()
    }
    
    let safariPid = safari.processIdentifier
    let safariElement = AXUIElementCreateApplication(safariPid)
    
    // get menu bar
    var menuBarPtr: CFTypeRef?
    _ = AXUIElementCopyAttributeValue(safariElement, kAXMenuBarRole as CFString, &menuBarPtr)
    
    guard let menuBarElement = menuBarPtr as! AXUIElement? else {
        fatalError()
    }
    
    // get menu bar items
    var menuBarItemsPtr: CFTypeRef?
    _ = AXUIElementCopyAttributeValue(menuBarElement, kAXChildrenAttribute as CFString, &menuBarItemsPtr)
    
    guard let menuBarItemsElement = menuBarItemsPtr as AnyObject as! [AXUIElement]? else {
        fatalError()
    }
    
    // history menu should always be on 6th place
    let historyMenuBarItemElement = menuBarItemsElement[5]
    
    // get history menu
    var historyMenuPtr: CFTypeRef?
    _ = AXUIElementCopyAttributeValue(historyMenuBarItemElement, kAXChildrenAttribute as CFString, &historyMenuPtr)
    
    guard let historyMenuElement = historyMenuPtr as! [AXUIElement]? else {
        fatalError()
    }
    print(historyMenuElement)
    
    // get all the items from history menu
    var historyMenuItemsPtr: CFTypeRef?
    _ = AXUIElementCopyAttributeValue(historyMenuElement[0], kAXChildrenAttribute as CFString, &historyMenuItemsPtr)
    
    guard let historyMenuItemsElement = historyMenuItemsPtr as! [AXUIElement]? else {
        fatalError()
    }
    
    // CFRelease ??
    
    return historyMenuItemsElement
    
}
