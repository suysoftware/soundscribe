//
//  FocusedPanelGetter.swift
//  Runner
//
//  Created by ILION INC on 16.03.2023.
//

import Foundation
import AppKit



func focusedPanelGetter(_ source: String) -> NSPanel {
    
    switch source {
        
        
    case "com.apple.dt.Xcode":
        return XcodePanel(contentRect: NSRect(x: 0, y: 0, width: 200, height: 25), styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
    case "com.hnc.Discord":
        return DiscordPanel(contentRect: NSRect(x: 0, y: 0, width: 200, height: 25), styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
    case "com.spotify.client":
        return SelectionBarPanel(contentRect: NSRect(x: 0, y: 0, width: 200, height: 25), styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
    default:
        return SelectionBarPanel(contentRect: NSRect(x: 0, y: 0, width: 200, height: 25), styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
    }
}






/*import Foundation
 import AppKit



 func focusedPanelGetter(_ source: String, nsRect: NSRect) -> NSPanel {
     
     switch source {
         
         
     case "com.apple.dt.Xcode":
         return XcodePanel(contentRect: nsRect, styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
     case "com.hnc.Discord":
         return DiscordPanel(contentRect: nsRect, styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
     case "com.spotify.client":
         return SelectionBarPanel(contentRect: nsRect, styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
     default:
         return SelectionBarPanel(contentRect: nsRect, styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
     }
 }
*/
