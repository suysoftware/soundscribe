//
//  SelectionBarView.swift
//  Runner
//
//  Created by ILION INC on 10.03.2023.
//

import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI







class SelectionBarView: NSView {
    
    
    //
    
    private let animationDuration: TimeInterval = 0.8
      
      private var isAnimating = false
      
      override init(frame frameRect: NSRect) {
          super.init(frame: frameRect)
          wantsLayer = true
          layer?.backgroundColor = Color(white: 0.1445,opacity: 0.75).cgColor
          
          layer?.cornerRadius = 5.0
          
          
         /* let image = NSImage(named: "mic_icon_x1")
          let imageView = NSImageView(frame: NSRect(x: sixthButtonX + (sixthButtonWidth/3), y: 0, width: 20, height: 20))
          imageView.image = image
       
          self.addSubview(imageView)*/
    
        
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      func animate(fromRect startRect: NSRect, toRect endRect: NSRect, completion: (() -> Void)? = nil) {
          guard !isAnimating else { return }
          isAnimating = true
          
          let layer = self.layer!
          
          // Set initial layer properties
          layer.opacity = 0
          layer.frame = startRect
          
          // Create and add the animation
          let animation = CABasicAnimation(keyPath: "frame")
          animation.fromValue = NSValue(rect: startRect)
          animation.toValue = NSValue(rect: endRect)
          animation.duration = animationDuration
          animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
          animation.fillMode = .forwards
          animation.isRemovedOnCompletion = false
          
          layer.add(animation, forKey: "frame")
          
          // Update layer properties after animation completes
          DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) { [weak self] in
              self?.isAnimating = false
              layer.frame = endRect
              completion?()
          }
          
          // Fade in the layer
          let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
          fadeInAnimation.fromValue = 0
          fadeInAnimation.toValue = 1
          fadeInAnimation.duration = animationDuration
          fadeInAnimation.fillMode = .forwards
          fadeInAnimation.isRemovedOnCompletion = false
          
          layer.add(fadeInAnimation, forKey: "opacity")
      }
    

    //
    
    override func draw(_ dirtyRect: NSRect) {
        // draw your custom appearance for the panel here
        // for example, a colored background with rounded corners
        //NSColor.blue.setFill()
        //let path = NSBezierPath(roundedRect: dirtyRect, xRadius: 10, yRadius: 10)
        //path.fill()
    }
    
}
