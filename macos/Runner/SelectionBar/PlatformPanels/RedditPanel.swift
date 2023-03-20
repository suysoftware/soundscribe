//
//  RedditPanel.swift
//  Runner
//
//  Created by ILION INC on 17.03.2023.
//

import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI

class RedditPanel: NSPanel {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: [.borderless, .nonactivatingPanel,], backing: backingStoreType, defer: flag)
        self.contentView = SelectionBarView(frame: contentRect)
        self.isOpaque = false
        self.level = .floating
        
        firstSelectionBarButton.title = "rdt1"
        secondSelectionBarButton.title = "rdt2"
        thirdSelectionBarButton.title = "rdt3"

        
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
