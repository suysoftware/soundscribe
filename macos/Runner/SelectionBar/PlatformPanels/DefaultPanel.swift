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
       
        
               //self.contentView?.frame = NSRect(x: 0, y: 0, width: 300, height: 35)
        /*
             firstSelectionBarButton.title = "Default saasf1"
             secondSelectionBarButton.title = "default asfas2"
             thirdSelectionBarButton.title = "default3"
             forthSelectionBarButton.title = "Podcast Recommendations"
             fifthSelectionBarButton.title = "Song Recognition"
             sixthSelectionBarButton.title = "Talk"
               
        changerFF()
     */
        self.contentView = SelectionBarView(frame: contentRect)
        self.isOpaque = false
        self.backgroundColor = NSColor.clear
        self.level = .floating
        
 
        
     
      
        
        
        
       self.contentView?.addSubview(firstSelectionBarButton)
        self.contentView?.addSubview(secondSelectionBarButton)
        self.contentView?.addSubview(thirdSelectionBarButton)
        self.contentView?.addSubview(forthSelectionBarButton)
        self.contentView?.addSubview(fifthSelectionBarButton)
        self.contentView?.addSubview(sixthSelectionBarButton)
        
        
        
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
