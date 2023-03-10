//
//  SelectionBarView.swift
//  Runner
//
//  Created by ILION INC on 10.03.2023.
//

import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI






class SelectionBarView: NSView {
    
    override func draw(_ dirtyRect: NSRect) {
        // draw your custom appearance for the panel here
        // for example, a colored background with rounded corners
        NSColor.blue.setFill()
        let path = NSBezierPath(roundedRect: dirtyRect, xRadius: 10, yRadius: 10)
        path.fill()
    }
    
}
