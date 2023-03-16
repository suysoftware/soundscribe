//
//  DiscordPanel.swift
//  Runner
//
//  Created by ILION INC on 16.03.2023.
//

import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI


class DiscordPanel: NSPanel {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: [.borderless, .nonactivatingPanel,], backing: backingStoreType, defer: flag)
        self.contentView = SelectionBarView(frame: contentRect)
        self.isOpaque = false
     
      /*
       let platformName = "com.hnc.Discord"
        
        let firstButton = platformFirstButtonGetter(platformName)
        self.contentView?.addSubview(firstButton)
        let secondButton = platformSecondButtonGetter(platformName)
        self.contentView?.addSubview(secondButton)
        let thirdButton = platformThirdButtonGetter(platformName)
        self.contentView?.addSubview(thirdButton)
        
    
    
        
        let speakButton = SelectionBarCustomButton(title: "speak", frame: NSRect(x: 150, y: 0, width: 50, height: 25))
        self.contentView?.addSubview(speakButton)
       */
       
        self.backgroundColor = NSColor.clear
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
