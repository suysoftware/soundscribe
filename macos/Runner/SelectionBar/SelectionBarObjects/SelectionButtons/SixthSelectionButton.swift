//
//  SixthSelectionButton.swift
//  Runner
//
//  Created by ILION INC on 22.03.2023.
//

import Foundation

import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI



class SixthSelectionButton: NSButton {

    
    required init(title string: String, frame rect: NSRect) {
          super.init(frame: rect)
          self.title = string
  
        
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
 


    override func draw(_ dirtyRect: NSRect) {
        // draw your custom appearance for the button here
        // for example, a colored background with a border and text label
        
        if self.isHighlighted {
            NSColor.systemBlue.setFill()
            //NSColor(red: 55, green: 116, blue: 244, alpha: 2.0).setFill()
            //     NSColor.blue.setFill()
            
        }
        else {
            NSColor.clear.setFill()
            
        }
        
        if self.isEnabled {
         
            if self.isHighlighted == false {
                NSColor.clear.setFill()
            }
            else {
                NSColor.systemBlue.setFill()
            }
        }
        else {
            NSColor.systemYellow.setFill()
            
        }
      
        //let path = NSBezierPath(ovalIn: dirtyRect)
        let path = NSBezierPath(roundedRect: dirtyRect, xRadius: 0, yRadius: 0)
         path.fill()
        
    
        

       
        //NSColor.blue.setStroke()
        //path.lineWidth = 2
        //path.stroke()
        
        //self.bezelStyle = .smallSquare
       
        
        //self.layer?.backgroundColor = Color(red: 56, green: 117, blue: 244).cgColor
        
        //self.translatesAutoresizingMaskIntoConstraints = false
        //let ss = Color(red: 56, green: 117, blue: 244);
        
        
        
     
       
        
       
        
        
        let image = NSImage(named: "mic_icon_x3")
        let imageView = NSImageView(frame: NSRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = image
     
        self.addSubview(imageView)
  
        
        

        
        let text = self.title
      
        let font = NSFont.systemFont(ofSize: 15,weight:  .regular)
        
        let textColor = NSColor.white
        
        let attributes = [NSAttributedString.Key.font: font,NSAttributedString.Key.foregroundColor: textColor]
         
        let textSize = text.size(withAttributes: attributes)
        //let textRect = dirtyRect
        let textRect = NSRect(x: dirtyRect.midX - (textSize.width / 2), y: dirtyRect.midY - (textSize.height / 2), width: textSize.width, height: textSize.height)
        text.draw(in: textRect, withAttributes: attributes)
        
        
        
  
        
    }
    
    
    
  
  
    
    override func mouseDown(with event: NSEvent) {
        sixthSelectionBarButton.isEnabled = false
        
        
        ChannelSingleton.shared.channel.invokeMethod("sBar/startRecord", arguments: nil, result: {(r:Any?) -> () in
            
            
            print(r.debugDescription);  // Never comes here
        })
        print(title)
        
        
        
        
        
        
        
        
        
    }
    override func mouseUp(with event: NSEvent) {
        
        sixthSelectionBarButton.isEnabled = true
        
        ChannelSingleton.shared.channel.invokeMethod("sBar/stopRecord", arguments: nil, result: {(r:Any?) -> () in
            
            
            print(r.debugDescription);  // Never comes here
        })
        print(title)
        
        
        
    }

    
}

