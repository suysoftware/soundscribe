//
//  WhatsappPanel.swift
//  Runner
//
//  Created by ILION INC on 17.03.2023.
//

import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI


class WhatsappPanel: NSPanel {
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: [.borderless, .nonactivatingPanel,], backing: backingStoreType, defer: flag)
        self.contentView = SelectionBarView(frame: contentRect)
        self.isOpaque = false
        self.backgroundColor = NSColor.clear
        self.level = .floating
        
 
        //self.contentView?.frame = NSRect(x: 0, y: 0, width: 300, height: 35)
        firstSelectionBarButton.title = "wp1"
        secondSelectionBarButton.title = "wp2"
        thirdSelectionBarButton.title = "wp3"
     

        self.contentView?.addSubview(firstSelectionBarButton)
        self.contentView?.addSubview(secondSelectionBarButton)
        self.contentView?.addSubview(thirdSelectionBarButton)
        self.contentView?.addSubview(forthSelectionBarButton)

  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
