//
//  StatusBarController.swift
//  Runner
//
//  Created by ILION INC on 8.03.2023.
//

import Foundation
import AppKit
import SwiftUI
import Cocoa

class StatusBarExtraController {
    private var statusBar: NSStatusBar
    private var statusItem: NSStatusItem
    private var mainView: NSView

    init(_ view: NSView) {
        self.mainView = view
        statusBar = NSStatusBar()
        statusItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        
    
        let iconSwiftUI = ZStack(alignment:.center) {
                 Rectangle()
                     .fill(Color.green)
                     .cornerRadius(10)
                     .padding(0)
             }

        
        let iconView = NSHostingView(rootView: iconSwiftUI)
                iconView.frame = NSRect(x: 0, y: 0, width: 15, height: 15)
        if let statusBarButton = statusItem.button {
            
            statusBarButton.title = "Soundscribe"
            statusBarButton.frame = iconView.frame
         
            let menuItem = NSMenuItem()
            menuItem.view = mainView
            let menu = NSMenu()
            
           
            
            menu.addItem(menuItem)
            statusItem.menu = menu
        }
        
    }
}
