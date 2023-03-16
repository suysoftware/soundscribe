//
//  PlatformButtonGetter.swift
//  Runner
//
//  Created by ILION INC on 16.03.2023.
//

import Foundation
import AppKit



func platformFirstButtonGetter(_ source: String) -> NSButton {
    
    switch source {
        
        
    case "com.apple.dt.Xcode":
        return SelectionBarCustomButton(title: "Xcode", frame: NSRect(x: 0, y: 0, width: 50, height: 25))
    case "com.hnc.Discord":
        return SelectionBarCustomButton(title: "Discord", frame: NSRect(x: 0, y: 0, width: 50, height: 25))
    case "com.spotify.client":
        return SelectionBarCustomButton(title: "Spotify", frame: NSRect(x: 0, y: 0, width: 50, height: 25))
    case "default":
        return SelectionBarCustomButton(title: "reply", frame: NSRect(x: 0, y: 0, width: 50, height: 25))
    default:
        return SelectionBarCustomButton(title: "reply", frame: NSRect(x: 0, y: 0, width: 50, height: 25))
    }
}



func platformSecondButtonGetter(_ source: String) -> NSButton {
    
    switch source {
        
        
    case "com.apple.dt.Xcode":
        return SelectionBarCustomButton(title: "Xcode", frame: NSRect(x: 50, y: 0, width: 50, height: 25))
    case "com.hnc.Discord":
        return SelectionBarCustomButton(title: "Discord", frame: NSRect(x: 50, y: 0, width: 50, height: 25))
    case "com.spotify.client":
        return SelectionBarCustomButton(title: "Spotify", frame: NSRect(x: 50, y: 0, width: 50, height: 25))
    case "default":
        return SelectionBarCustomButton(title: "trans", frame: NSRect(x: 50, y: 0, width: 50, height: 25))
    default:
        return SelectionBarCustomButton(title: "trans", frame: NSRect(x: 50, y: 0, width: 50, height: 25))
    }
}




func platformThirdButtonGetter(_ source: String) -> NSButton {
    
    switch source {
        
        
    case "com.apple.dt.Xcode":
        return SelectionBarCustomButton(title: "Xcode", frame: NSRect(x: 100, y: 0, width: 50, height: 25))
    case "com.hnc.Discord":
        return SelectionBarCustomButton(title: "Discord", frame: NSRect(x: 100, y: 0, width: 50, height: 25))
    case "com.spotify.client":
        return SelectionBarCustomButton(title: "Spotify", frame: NSRect(x: 100, y: 0, width: 50, height: 25))
    case "default":
        return SelectionBarCustomButton(title: "concl", frame: NSRect(x: 100, y: 0, width: 50, height: 25))
    default:
        return SelectionBarCustomButton(title: "concl", frame: NSRect(x: 100, y: 0, width: 50, height: 25))
    }
}
