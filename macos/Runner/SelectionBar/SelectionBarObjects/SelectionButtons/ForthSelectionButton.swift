//
//  ForthSelectionButton.swift
//  Runner
//
//  Created by ILION INC on 22.03.2023.
//

import Foundation

import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI



class ForthSelectionButton: NSButton {

    
    required init(title string: String, frame rect: NSRect) {
          super.init(frame: rect)
          self.title = string
 
        
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
 
    override func draw(_ dirtyRect: NSRect) {
      
        
        if self.isHighlighted {
            NSColor.systemBlue.setFill()
         
        }
        else {
            NSColor.clear.setFill()
         
        }

        let path = NSBezierPath(roundedRect: dirtyRect, xRadius: 0, yRadius: 0)
         path.fill()
        
    
        

        
        let text = self.title
        let font = NSFont.systemFont(ofSize: 15,weight:  .regular)
        let textColor = NSColor.white
        let attributes = [NSAttributedString.Key.font: font,NSAttributedString.Key.foregroundColor: textColor]
        let textSize = text.size(withAttributes: attributes)
        let textRect = NSRect(x: dirtyRect.midX - (textSize.width / 2), y: dirtyRect.midY - (textSize.height / 2), width: textSize.width, height: textSize.height)
        text.draw(in: textRect, withAttributes: attributes)
        
        
    }
override func mouseDown(with event: NSEvent) {
    
    let buttonAction = buttonActionGetter(17, platformNo: platformNo)
  

         
         ChannelSingleton.shared.channel.invokeMethod("sBar/\(title)", arguments: buttonAction, result: {(r:Any?) -> () in
             
       
             print(r.debugDescription);  // Never comes here
                     })
                 print(title)
         
     
         
         
     

         

    }


    
}

