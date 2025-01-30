//
//  MouseClickHandler.swift
//  KeyPressed
//
//  Created by Christian Fischer on 30.06.22.
//

import Foundation
import Cocoa

extension AppDelegate {
    func keyPress() {
        let win = WindowHandler()
        
        ev = EventMonitor { i in
            // get application in the foreground
            var app = win.getFrontmostApplication()
            handleApplicationClicks(app: app, mouseButton: i.buttonNumber)
        }
        
        ev?.start()
    }
}
