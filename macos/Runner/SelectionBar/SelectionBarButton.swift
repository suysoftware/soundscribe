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
        NSColor.gray.setFill()
        let path = NSBezierPath(roundedRect: dirtyRect, xRadius: 5, yRadius: 5)
        path.fill()
        
        NSColor.black.setStroke()
        path.lineWidth = 2
        path.stroke()
        
        self.bezelStyle = .rounded

        self.translatesAutoresizingMaskIntoConstraints = false
       
        let text = self.title
        let font = NSFont.systemFont(ofSize: 16,weight:  .semibold)
        
        let attributes = [NSAttributedString.Key.font: font,]
         
        let textSize = text.size(withAttributes: attributes)
        let textRect = NSRect(x: dirtyRect.midX - (textSize.width / 2), y: dirtyRect.midY - (textSize.height / 2), width: textSize.width, height: textSize.height)
        text.draw(in: textRect, withAttributes: attributes)
        
    }
    func getSelectedText() -> String? {
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
    }
   
    
override func mouseDown(with event: NSEvent) {
        
     //
    
   // let text = self.getSelectedText()
    //print(text)
         //
  
        //print(AXUIElement.focusedElement?.selectedText!)
        
        
        ChannelSingleton.shared.channel.invokeMethod("sBar/\(title)", arguments: nil, result: {(r:Any?) -> () in
            
      
            print(r.debugDescription);  // Never comes here
                    })
                print(title)
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


extension AXUIElement {
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
