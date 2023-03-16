//
//  XcodePanel.swift
//  Runner
//
//  Created by ILION INC on 16.03.2023.
//



import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI


class XcodePanel: NSPanel {
  
    
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: [.borderless, .nonactivatingPanel,], backing: backingStoreType, defer: flag)
        self.contentView = SelectionBarView(frame: contentRect)
        self.isOpaque = false
        
        /*
         let platformName = "com.apple.dt.Xcode"
        
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
/*
self.mouseEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseUp, .leftMouseDown, .leftMouseDragged, .mouseMoved, .scrollWheel ]) { [weak self] event in
    guard self != nil else { return }
    
    
    
    if event.type == .mouseMoved {
        
        //reply button active/passive
        if(event.locationInWindow.x > 1 && event.locationInWindow.x < 50.0 && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
            
            
            
            firstButton.isHighlighted = true
            
            
            
        }
        else {
            
            firstButton.isHighlighted = false
            
        }
        
        
        //trans button active/passive
        if(event.locationInWindow.x > 50 && event.locationInWindow.x < 100.0 && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
            
            secondButton.isHighlighted = true
            
            
        }
        else {
            secondButton.isHighlighted = false
        }
        
        
        
        //concl button active/passive
        if(event.locationInWindow.x > 100 && event.locationInWindow.x < 150.0 && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
            
            thirdButton.isHighlighted = true
            
            
        }
        else {
            thirdButton.isHighlighted = false
        }
        
        
        
        //speak button active/passive
        if(event.locationInWindow.x > 150 && event.locationInWindow.x < 200.0 && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
            
            speakButton.isHighlighted = true
            
            
        }
        else {
            speakButton.isHighlighted = false
        }
        
        
        
        
        
    }

}*/
