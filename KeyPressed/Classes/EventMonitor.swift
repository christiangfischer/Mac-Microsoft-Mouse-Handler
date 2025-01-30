//
//  EventMonitor.swift
//  Microsoft Mouse Handler
//
//  Created by Christian Fischer on 15.07.22.
//

import Foundation
import AppKit

class EventMonitor {
    private var monitor: Any?
    private var handler: (NSEvent) -> Void
    
    init(handler: @escaping (NSEvent) -> Void) {
        self.handler = handler
    }
    
    func start() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: .otherMouseDown, handler: handler)
    }
    
    func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
        }
    }
}
