//
//  FinderControl.swift
//  Microsoft Mouse Handler
//
//  Created by Christian Fischer on 16.07.22.
//

import Foundation

import Foundation
import AppKit

class Finder: Application {
    var buttonElement: AXUIElement?
    
    func getButtonForMouseClick(mouseButton: Int) -> AXUIElement {
        print("before click")
        if mouseButton == 3 {
            // backwards
            buttonElement = try? getBackwardElement()
        } else if mouseButton == 4 {
            // forward
            buttonElement = try? getForwardElement()
        }
        
        return buttonElement!
    }
    
    func getBackwardElement() throws -> AXUIElement {
        guard let historyMenuItemsElement = try? getHistoryMenuItemsElement()[0] else {
            throw ControlErrors.menuItemNotFound("backwards item")
        }
        
//        var namesPtr: CFTypeRef?
//        _ = AXUIElementCopyAttributeValue(historyMenuItemsElement, "AXIdentifier" as CFString, &namesPtr)
//        guard namesPtr as! String == "Back" else {
//            throw ControlErrors.menuItemNotFound("backwards item")
//        }
        
        return historyMenuItemsElement
    }
    
    func getForwardElement() throws -> AXUIElement {
        guard let historyMenuItemsElement = try? getHistoryMenuItemsElement()[1] else {
            throw ControlErrors.menuItemNotFound("forward item")
        }
        
//        var namesPtr: CFTypeRef?
//        _ = AXUIElementCopyAttributeValue(historyMenuItemsElement, "AXIdentifier" as CFString, &namesPtr)
//        guard namesPtr as! String == "Forward" else {
//            throw ControlErrors.menuItemNotFound("forward item")
//        }
        
        return historyMenuItemsElement
    }
    
    private func getHistoryMenuItemsElement() throws -> [AXUIElement] {
        let finderElement = try getWindowElement(appName: "com.apple.finder")
        
        // get menu bar
        var menuBarPtr: CFTypeRef?
        _ = AXUIElementCopyAttributeValue(finderElement, kAXMenuBarRole as CFString, &menuBarPtr)
        
        guard let menuBarElement = menuBarPtr as! AXUIElement? else {
            throw ControlErrors.failedToAccessMenuBar
        }
        
        // get menu bar items
        var menuBarItemsPtr: CFTypeRef?
        _ = AXUIElementCopyAttributeValue(menuBarElement, kAXChildrenAttribute as CFString, &menuBarItemsPtr)
        
        guard let menuBarItemsElement = menuBarItemsPtr as AnyObject as! [AXUIElement]? else {
            throw ControlErrors.failedToAccessMenuBarItems
        }
        
        // history menu should always be on 6th place
        let historyMenuBarItemElement = menuBarItemsElement[5]
        
        // get history menu
        var historyMenuPtr: CFTypeRef?
        _ = AXUIElementCopyAttributeValue(historyMenuBarItemElement, kAXChildrenAttribute as CFString, &historyMenuPtr)
        
        guard let historyMenuElement = historyMenuPtr as! [AXUIElement]? else {
            throw ControlErrors.historyMenuNotFound
        }
        print(historyMenuElement)
        
        // get all the items from history menu
        var historyMenuItemsPtr: CFTypeRef?
        _ = AXUIElementCopyAttributeValue(historyMenuElement[0], kAXChildrenAttribute as CFString, &historyMenuItemsPtr)
        
        guard let historyMenuItemsElement = historyMenuItemsPtr as! [AXUIElement]? else {
            throw ControlErrors.historyMenuItemNotFound
        }
        
        return historyMenuItemsElement
    }
}
