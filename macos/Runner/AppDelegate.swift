import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI








@NSApplicationMain
class AppDelegate: FlutterAppDelegate, NSMenuDelegate {
    let channelName: String = "soundscribe.suy/statusBarChannel"
    var statusBarExtra: StatusBarExtraController?
    var customPanel: SelectionBarPanel?
    //var menuItem: NSMenuItem?//v2
    var mouseEventMonitor: Any?
    var textSelectionObserver: Any?
    
    //
    let systemWideElement = AXUIElementCreateSystemWide()
    var focusedElement : AnyObject?

    
    // Set the layer's properties
   
    
 
  
    
    
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        
        
        return false
    }
    
    
    override func applicationDidFinishLaunching(_ notification: Notification) {
      
        
        
        //
     
   
        //
 
 
        WindowSingleton.shared.window = mainFlutterWindow?.contentViewController as! FlutterViewController
        
        
        let prompt = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String
        let options: NSDictionary = [prompt: true]
        let appHasPermission = AXIsProcessTrustedWithOptions(options)
        
        //
        
      
        var clickedArea : NSPoint?
        
        
        
        //
        
        
        let controller : FlutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
        
        
        let channel = FlutterMethodChannel.init(name: channelName, binaryMessenger: controller.engine.binaryMessenger)
        
        ChannelSingleton.shared.channel = channel
        
        //let channelSender = FlutterMethodChannel.init(name: CHANNEL_SENDER_NAME, binaryMessenger: controller.engine.binaryMessenger)
        
        //let contentView = ContentView()
        //let mainView = NSHostingView(rootView: contentView)
        //mainView.frame =  NSRect(x: 0, y: 0, width: 300, height: 200)
        //statusBar = StatusBarController(mainView)
        
        
        let statusBarContent = StatusBarContent()
        let mainExtraView = NSHostingView(rootView: statusBarContent)
        mainExtraView.frame =  NSRect(x: 0, y: 0, width: 250, height: 300)
        statusBarExtra = StatusBarExtraController(mainExtraView)
        
        
        channel.setMethodCallHandler({ (_ call: FlutterMethodCall, _ result: FlutterResult) -> Void in
            
            if ("getAppIntents" == call.method) {
                
                result("test")
                return
                
            }
            if ("firstTaskFinished" == call.method) {
                
                FirstTaskSingleton.instance.SetData(value: true)
                return
                
            }
            else if("getBatteryLevel" == call.method) {
                let internalFinder = InternalFinder()
                if let internalBattery = internalFinder.getInternalBattery() {
                    result(internalBattery.charge)
                    return
                }
                result(0.0)
            } else if("isBatteryCharging" == call.method) {
                let internalFinder = InternalFinder()
                if let internalBattery = internalFinder.getInternalBattery() {
                    result(internalBattery.isCharging)
                    return
                }
                result(false)
            } else if("getBatteryTimeLeft" == call.method) {
                let internalFinder = InternalFinder()
                if let internalBattery = internalFinder.getInternalBattery() {
                    result(internalBattery.timeLeft)
                    return
                }
                result("")
            }else {
                result(FlutterMethodNotImplemented)
            }
        });
        
        
        let panelRect = NSRect(x: 0, y: 0, width: 200, height: 30)
        self.customPanel = SelectionBarPanel(contentRect: panelRect, styleMask: [.borderless, .nonactivatingPanel], backing: .buffered, defer: false)
        
        // Create a custom button and add it to the panel
        
        
        self.customPanel?.level = .floating
        
        
        let replyButton = SelectionBarCustomButton(title: "reply", frame: NSRect(x: 0, y: 0, width: 40, height: 30))
        self.customPanel?.contentView?.addSubview(replyButton)
        let tsButton = SelectionBarCustomButton(title: "trans", frame: NSRect(x: 70, y: 0, width: 40, height: 30))
        self.customPanel?.contentView?.addSubview(tsButton)
        let concButton = SelectionBarCustomButton(title: "concl", frame: NSRect(x: 140, y: 0, width: 40, height: 30))
        self.customPanel?.contentView?.addSubview(concButton)
        
        
        
        
        self.mouseEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseUp, .leftMouseDown, .leftMouseDragged, .mouseMoved]) { [weak self] event in
            guard let self = self else { return }
            
            
            
        
             if event.type == .leftMouseDown {
                // Hide the custom panel if it's currently visible
                 clickedArea = event.locationInWindow
                 
           
                
                print("left")
                self.customPanel?.orderOut(nil)
            }
          
            else if    event.type == .leftMouseUp && clickedArea != nil {
                
                
                if event.locationInWindow.x -  clickedArea!.x > 20 ||    clickedArea!.x - event.locationInWindow.x > 20 || event.locationInWindow.y -  clickedArea!.y > 20 ||    clickedArea!.y - event.locationInWindow.y > 20 {
                    
                    /* event.locationInWindow.x != (clickedArea?.x+10) ||
                     event.locationInWindow.x != (clickedArea?.x -10) ||
                     
                     event.locationInWindow.y != (clickedArea?.y +10) ||
                     event.locationInWindow.y != (clickedArea?.y-10)
                 */
                   
                 print("other")
           //
                  
                
       
                 //
                 let error = AXUIElementCopyAttributeValue(self.systemWideElement, kAXFocusedUIElementAttribute as CFString, &self.focusedElement)
                     if (error != .success){
                        // print(error)
                        // print("Couldn't get the focused element. Probably a webkit application")
                     } else {
                         var selectedRangeValue : AnyObject?
                         let selectedRangeError = AXUIElementCopyAttributeValue(self.focusedElement as! AXUIElement, kAXSelectedTextRangeAttribute as CFString, &selectedRangeValue)
                         if (selectedRangeError == .success){
                             var selectedRange : CFRange?
                             AXValueGetValue(selectedRangeValue as! AXValue, AXValueType(rawValue: kAXValueCFRangeType)!, &selectedRange)
                             var selectRect = CGRect()
                             var selectBounds : AnyObject?
                             let selectedBoundsError = AXUIElementCopyParameterizedAttributeValue(self.focusedElement as! AXUIElement, kAXBoundsForRangeParameterizedAttribute as CFString, selectedRangeValue!, &selectBounds)
                             if (selectedBoundsError == .success){
                                 AXValueGetValue(selectBounds as! AXValue, .cgRect, &selectRect)
                                 //do whatever you want with your selectRect
                                 print(selectRect)
                             }
                         }
                     }
                 
               
             
                 //
                 
                 
                 
                 // Check if any text is selected and show the custom panel if necessary
                 
                 let selectedRange = NSApplication.shared.keyWindow?.fieldEditor(true, for: nil)?.selectedRange
              
                 if selectedRange?.length ?? 0 > 0 || selectedRange?.length ==  nil, let customPanel = self.customPanel {
                     // Calculate the location of the mouse click in screen coordinates
                     print("calisti")
                     let mouseLocation = NSEvent.mouseLocation
                     let panelOrigin = NSPoint(x: mouseLocation.x - panelRect.width*0.6 , y: mouseLocation.y + panelRect.height*0.2 )
                     let screenFrame = NSScreen.main?.frame ?? NSRect.zero
                     
                     // Check if the panel would be offscreen and adjust if necessary
                     var panelFrame = NSRect(origin: panelOrigin, size: panelRect.size)
                     if panelFrame.origin.x < screenFrame.origin.x {
                         panelFrame.origin.x = screenFrame.origin.x
                     }
                     if panelFrame.origin.y < screenFrame.origin.y {
                         panelFrame.origin.y = screenFrame.origin.y
                     }
                     if panelFrame.maxX > screenFrame.maxX {
                         panelFrame.origin.x = screenFrame.maxX - panelFrame.width
                     }
                     if panelFrame.maxY > screenFrame.maxY {
                         panelFrame.origin.y = screenFrame.maxY - panelFrame.height
                     }
                     
                     // Show the custom panel at the calculated location
                     customPanel.setFrame(panelFrame, display: true)
                     customPanel.makeKeyAndOrderFront(nil)
                 }
             }
         }
         self.textSelectionObserver = NotificationCenter.default.addObserver(forName: NSTextView.didChangeSelectionNotification, object: nil, queue: nil) { [weak self] notification in
             guard let self = self else { return }
             
             
             
         }
         
         //v2 show the panel
         
         
         //
         
         // Show the panel
         /* NSEvent.addGlobalMonitorForEvents(matching: .rightMouseDown) { event in
          if let customPanel = self.customPanel {
          // Calculate the location of the mouse click in screen coordinates
          let mouseLocation = NSEvent.mouseLocation
          
          let panelOrigin = NSPoint(x: mouseLocation.x - panelRect.width / 2, y: mouseLocation.y - panelRect.height / 2)
          let screenFrame = NSScreen.main?.frame ?? NSRect.zero
          
          // Check if the panel would be offscreen and adjust if necessary
          var panelFrame = NSRect(origin: panelOrigin, size: panelRect.size)
          if panelFrame.origin.x < screenFrame.origin.x {
          panelFrame.origin.x = screenFrame.origin.x
          }
          if panelFrame.origin.y < screenFrame.origin.y {
          panelFrame.origin.y = screenFrame.origin.y
          }
          if panelFrame.maxX > screenFrame.maxX {
          panelFrame.origin.x = screenFrame.maxX - panelFrame.width
          }
          if panelFrame.maxY > screenFrame.maxY {
          panelFrame.origin.y = screenFrame.maxY - panelFrame.height
          }
          
          // Show the custom panel at the calculated location
          customPanel.setFrame(panelFrame, display: true)
          customPanel.makeKeyAndOrderFront(nil)
          
          }
          }
          */
         
         //let customButton = NSButton(frame: NSMakeRect(10, 10, 50, 30))
         //let selectionBarView = SelectionBarView(frame: NSMakeRect(0, 0, 200, 50))
         
         
         
         
         
                    
                }
               
    }
    
    
    
    
}
    
    


