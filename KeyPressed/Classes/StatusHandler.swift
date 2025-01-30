//
//  StatusHandler.swift
//  KeyPressed
//
//  Created by Christian Fischer on 30.06.22.
//

import Foundation

class StatusHandler {
    private var status: Bool
    
    init(status: Bool) {
        self.status = status
    }
    
    func enableAdvancedMouseHandling() {
        self.status = true
    }
    
    func disableAdvancedMouseHandling() {
        self.status = false
    }
    
    func isAdvancedMouseHandlingEnabled() -> Bool {
        return self.status
    }
}
