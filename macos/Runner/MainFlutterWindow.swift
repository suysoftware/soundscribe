import Cocoa
import FlutterMacOS
import window_manager
import AppKit
import SwiftUI




class MainFlutterWindow: NSWindow {
    
    


  override func awakeFromNib() {
      
      
      let flutterViewController = FlutterViewController.init()
      let windowFrame = self.frame
      self.contentViewController = flutterViewController
      self.setFrame(windowFrame, display: true)
      print(self.attributeKeys)
      
  
     
      
    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
  
   override public func order(_ place: NSWindow.OrderingMode, relativeTo otherWin: Int) {
      super.order(place, relativeTo: otherWin)
      hiddenWindowAtLaunch()
   }
}


