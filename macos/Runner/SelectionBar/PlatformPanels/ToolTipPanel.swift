
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
        self.level = .popUpMenu
        
 
        
     
      
        
        
        
       self.contentView?.addSubview(toolTipText)
      
        
        
        
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
