//
//  GmailPanel.swift
//  Runner
//
//  Created by ILION INC on 17.03.2023.
//

import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI


class GmailPanel: NSPanel {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: [.borderless, .nonactivatingPanel,], backing: backingStoreType, defer: flag)
        self.contentView = SelectionBarView(frame: contentRect)
        self.isOpaque = false
        self.level = .floating
        
        firstSelectionBarButton.title = "gmai1"
        secondSelectionBarButton.title = "gmai2"
        thirdSelectionBarButton.title = "gmai3"
        forthSelectionBarButton.title = "gmai4"
        
        self.contentView?.addSubview(firstSelectionBarButton)
        self.contentView?.addSubview(secondSelectionBarButton)
        self.contentView?.addSubview(thirdSelectionBarButton)
        self.contentView?.addSubview(forthSelectionBarButton)


        self.backgroundColor = NSColor.clear
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}