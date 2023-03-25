//
//  SendGlobalCopyEvent.swift
//  Runner
//
//  Created by ILION INC on 25.03.2023.
//

import Cocoa
import TabularData
import FlutterMacOS
import AppKit
import SwiftUI
import Carbon
import ApplicationServices // Import the ApplicationServices framework
import CoreGraphics

func sendGlobalCommandC(){
        
    let cmdKeyDown = CGEvent(keyboardEventSource: nil, virtualKey: 0x37, keyDown: true) // CMD key down
    let cmdKeyUp = CGEvent(keyboardEventSource: nil, virtualKey: 0x37, keyDown: false) // CMD key up

    let cKeyDown = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: true) // C key down
    let cKeyUp = CGEvent(keyboardEventSource: nil, virtualKey: 0x08, keyDown: false) // C key up

    cmdKeyDown?.flags = .maskCommand
    cKeyDown?.flags = .maskCommand

    let eventTapLocation = CGEventTapLocation.cghidEventTap // System-wide event tap

    cmdKeyDown?.post(tap: eventTapLocation)
    cKeyDown?.post(tap: eventTapLocation)
    cKeyUp?.post(tap: eventTapLocation)
    cmdKeyUp?.post(tap: eventTapLocation)
    
  
    
}

