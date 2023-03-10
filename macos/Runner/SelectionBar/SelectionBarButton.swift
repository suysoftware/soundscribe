//
//  SelectionBarButton.swift
//  Runner
//
//  Created by ILION INC on 10.03.2023.
//


import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI


class SelectionBarCustomButton: NSButton {
    
    
    override func draw(_ dirtyRect: NSRect) {
        // draw your custom appearance for the button here
        // for example, a colored background with a border and text label
        NSColor.red.setFill()
        let path = NSBezierPath(roundedRect: dirtyRect, xRadius: 5, yRadius: 5)
        path.fill()
        
        NSColor.black.setStroke()
        path.lineWidth = 2
        path.stroke()
        
        let text = self.title
        let font = NSFont.systemFont(ofSize: NSFont.systemFontSize)
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: NSColor.white]
        let textSize = text.size(withAttributes: attributes)
        let textRect = NSRect(x: dirtyRect.midX - (textSize.width / 2), y: dirtyRect.midY - (textSize.height / 2), width: textSize.width, height: textSize.height)
        text.draw(in: textRect, withAttributes: attributes)
    }
    
    override func mouseDown(with event: NSEvent) {
        // handle button click event
    }

    
    
    /*override func draw(_ dirtyRect: NSRect) {
        NSColor.white.setFill()
        dirtyRect.fill()
        
        NSColor.black.setStroke()
        NSBezierPath(rect: dirtyRect).stroke()
        
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let attrs = [
            NSAttributedString.Key.font: NSFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: NSColor.black,
            NSAttributedString.Key.paragraphStyle: textStyle
        ]
        let string = NSAttributedString(string: self.title, attributes: attrs)
        let stringRect = NSRect(x: 0, y: 0, width: dirtyRect.width, height: dirtyRect.height)
        string.draw(in: stringRect)
    }
    
    
    */
}
