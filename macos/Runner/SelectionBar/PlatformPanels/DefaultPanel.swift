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


class DefaultPanel: NSPanel {
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: [.borderless, .nonactivatingPanel,], backing: backingStoreType, defer: flag)
        self.contentView = SelectionBarView(frame: contentRect)
        self.isOpaque = false
        self.backgroundColor = NSColor.clear
        self.level = .floating
    
        
        firstSelectionBarButton.title = "dea1"
        secondSelectionBarButton.title = "defa"
        thirdSelectionBarButton.title = "defa3"

        self.contentView?.addSubview(firstSelectionBarButton)
        self.contentView?.addSubview(secondSelectionBarButton)
        self.contentView?.addSubview(thirdSelectionBarButton)
        self.contentView?.addSubview(forthSelectionBarButton)
        
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
