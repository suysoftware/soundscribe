//
//  ImagePreviewPanel.swift
//  Runner
//
//  Created by ILION INC on 18.03.2023.
//

import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI

class ImagePreviewPanel: NSPanel {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: [.borderless, .nonactivatingPanel,], backing: backingStoreType, defer: flag)
        self.contentView = SelectionBarView(frame: contentRect)
        self.isOpaque = false
        self.level = .floating
        
        
        
   

        self.backgroundColor = NSColor.clear
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
