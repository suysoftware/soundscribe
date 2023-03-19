//
//  SelectionBarButton.swift
//  Runner
//
//  Created by ILION INC on 10.03.2023.
//



import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI



class SelectionBarCustomButton: NSButton {
    var mouseEventMonitor: Any?
    
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
        
        
        
        
        
        let text = self.title
      
        let font = NSFont.systemFont(ofSize: 15,weight:  .regular)
        
        let textColor = NSColor.white
        
        let attributes = [NSAttributedString.Key.font: font,NSAttributedString.Key.foregroundColor: textColor]
         
        let textSize = text.size(withAttributes: attributes)
        //let textRect = dirtyRect
        let textRect = NSRect(x: dirtyRect.midX - (textSize.width / 2), y: dirtyRect.midY - (textSize.height / 2), width: textSize.width, height: textSize.height)
        text.draw(in: textRect, withAttributes: attributes)
        
        
        
  
        
    }
    
    
    
    func sendGlobalCommandC() -> Bool?{
        
   
        
        
        
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
        
        return true
        
    }
    
    
    
    
  /*  func getSelectedText() -> String? {
        // Get the currently active application
        guard let frontmostApplication = NSWorkspace.shared.frontmostApplication,
              let _ = NSRunningApplication(processIdentifier: frontmostApplication.processIdentifier) else {
                return nil
        }

        // Get the AXUIElement for the application
        let applicationElement = AXUIElementCreateApplication(frontmostApplication.processIdentifier)

        var focusedElement: CFTypeRef?
        let result = AXUIElementCopyAttributeValue(
            applicationElement,
            kAXSelectedTextAttribute as CFString,
            &focusedElement
        )
        print(result)
        // !!! result = AxError: cannotComplete !!!
        if result != .success {
           return nil
        }

        let focusedUIElement = focusedElement as! AXUIElement

        // Get the selected text
        var selectedText: AnyObject?
        let selectedTextResult = AXUIElementCopyAttributeValue(focusedUIElement, kAXSelectedTextAttribute as CFString, &selectedText)

        if selectedTextResult == .success, let selectedText = selectedText as? String {
            return selectedText
        } else {
            // Try getting the value of the focused element instead
            var value: AnyObject?
            let valueResult = AXUIElementCopyAttributeValue(focusedUIElement, kAXValueAttribute as CFString, &value)

            if valueResult == .success, let value = value as? String {
                return value
            } else {
                return nil
            }
        }
    }*/
   

  
    
override func mouseDown(with event: NSEvent) {
 
    if let keyResult = sendGlobalCommandC() {
        
        
        ChannelSingleton.shared.channel.invokeMethod("sBar/\(title)", arguments: nil, result: {(r:Any?) -> () in
            
      
            print(r.debugDescription);  // Never comes here
                    })
                print(title)
        
    }

  
   
   
   // let text = self.getSelectedText()
    //print(text)
         //
   
    
        
        
       
        // handle button click event
    }

    
    
    /*override func draw(_ dirtyRect: NSRect) {
        NSColor.white.setFill()
        dirtyRect.fill()
        
        NSColor.black.setStroke()
        NSBezierPath(rect: dirtyRect).stroke()
        
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let attrs = [
            NSAttributedString.Key.font: NSFont.systemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: NSColor.black,
            NSAttributedString.Key.paragraphStyle: textStyle
        ]
        let string = NSAttributedString(string: self.title, attributes: attrs)
        let stringRect = NSRect(x: 0, y: 0, width: dirtyRect.width, height: dirtyRect.height)
        string.draw(in: stringRect)
    }
    
    
    */
}


/*extension AXUIElement {
  static var focusedElement: AXUIElement? {
    systemWide.element(for: kAXFocusedUIElementAttribute)
  }
  
  var selectedText: String? {
    rawValue(for: kAXSelectedTextAttribute) as? String
  }
  
  private static var systemWide = AXUIElementCreateSystemWide()
  
  private func element(for attribute: String) -> AXUIElement? {
    guard let rawValue = rawValue(for: attribute), CFGetTypeID(rawValue) == AXUIElementGetTypeID() else { return nil }
    return (rawValue as! AXUIElement)
  }
  
  private func rawValue(for attribute: String) -> AnyObject? {
    var rawValue: AnyObject?
    let error = AXUIElementCopyAttributeValue(self, attribute as CFString, &rawValue)
    return error == .success ? rawValue : nil
  }
}
*/
