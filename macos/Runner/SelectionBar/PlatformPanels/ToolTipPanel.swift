
//
//  DefaultPanel.swift
//  Runner
//
//  Created by ILION INC on 16.03.2023.
//



import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI


class ToolTipPanel: NSPanel {
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: [.borderless, .nonactivatingPanel,], backing: backingStoreType, defer: flag)
       

        self.contentView = ToolTipView(frame: toolTipRect)
        self.isOpaque = false
        self.backgroundColor = NSColor.clear
        self.level = .floating
        
 
        
     
        let textField = NSTextField(frame: NSMakeRect(10, 10, 300, 100))
        textField.stringValue = toolTipString
        textField.isEditable = false
        textField.isBordered = false
        textField.drawsBackground = false
   
        let maxSize = NSMakeSize(300, CGFloat.greatestFiniteMagnitude)
        let textSize = textField.cell!.cellSize(forBounds: NSMakeRect(0, 0, 300, CGFloat.greatestFiniteMagnitude))
        let contentRect = NSMakeRect(0, 0, textSize.width + 20, textSize.height + 20)
        self.setContentSize(contentRect.size)
        textField.frame = NSMakeRect(10, 10, textSize.width, textSize.height)
        

        self.contentView?.addSubview(textField)
        
      // self.contentView?.addSubview(toolTipText)
      
        
        
        
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
