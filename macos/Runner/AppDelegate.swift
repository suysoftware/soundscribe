import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI
import Carbon
import ApplicationServices // Import the ApplicationServices framework
import CoreGraphics



@NSApplicationMain
class AppDelegate: FlutterAppDelegate, NSMenuDelegate {
    let channelName: String = "soundscribe.suy/statusBarChannel"
    var statusBarExtra: StatusBarExtraController?
    var customPanel: SelectionBarPanel?
    //var menuItem: NSMenuItem?//v2
    var mouseEventMonitor: Any?
    var mouseCGEventMonitor: Any?
    var textSelectionObserver: Any?
    
    let systemWideElement = AXUIElementCreateSystemWide()
    var focusedElement : AnyObject?

    

    let getSelectedTextScript = """
        tell application "System Events"
            set frontmostProcess to first process where it is frontmost
            set appName to name of frontmostProcess
        end tell

        tell application appName
            try
                set selectedText to the clipboard
                set currentClipboard to the clipboard
                set the clipboard to ""
                tell application "System Events" to keystroke "c" using {command down}
                delay 0.5
                set selectedText to the clipboard as text
                set the clipboard to currentClipboard
            on error errMsg
                return errMsg
            end try
        end tell

        return selectedText
    """
   
    
    //
    func sendGlobalCommandC() {
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
    }
    
    
    func runAppleScript(_ source: String) -> String? {
        var error: NSDictionary?
        if let scriptObject = NSAppleScript(source: source) {
            let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(&error)
            if error != nil {
                print("AppleScript execution failed: \(error!)")
                return nil
            } else {
                return output.stringValue
            }
        } else {
            print("AppleScript compilation failed")
            return nil
        }
    }
    

    let menuDelegate = NSMenuDelegate.self

    let editMenu = NSMenuItem()

   /* func copyToClipboard(_ string: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(string, forType: .string)
    }*/
   
    
    // Set the layer's properties
    
    /*
   func getClipboardText() -> String? {
        let pasteboard = NSPasteboard.general
        let items = pasteboard.pasteboardItems
        let item = items?.first

        return item?.string(forType: .string)
    }
  */
 


  
   
    
    
    
    
    
    
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        
        
        return false
    }
    
 

    override func applicationDidFinishLaunching(_ notification: Notification) {
        
        WindowSingleton.shared.window = mainFlutterWindow?.contentViewController as! FlutterViewController
        
    
      
        
        
        // First, get a reference to the other application's window that contains the selected text.
        
   
      
        var clickedArea : NSPoint?
        
        
        
        //
        
        
        let controller : FlutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
        
        
        let channel = FlutterMethodChannel.init(name: channelName, binaryMessenger: controller.engine.binaryMessenger)
        
        ChannelSingleton.shared.channel = channel
        
   
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
        
        
   
        
        

    
        
   

    
        
        
        let panelRect = NSRect(x: 0, y: 0, width: 200, height: 25)
        self.customPanel = SelectionBarPanel(contentRect: panelRect, styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
        
        // Create a custom button and add it to the panel
      
    self.customPanel?.level = .floating
        
        
        
    
        
        let replyButton = SelectionBarCustomButton(title: "reply", frame: NSRect(x: 0, y: 0, width: 50, height: 25))
        //replyButton.isHighlighted = true
        self.customPanel?.contentView?.addSubview(replyButton)
        let tsButton = SelectionBarCustomButton(title: "trans", frame: NSRect(x: 50, y: 0, width: 50, height: 25))
        self.customPanel?.contentView?.addSubview(tsButton)
        let concButton = SelectionBarCustomButton(title: "concl", frame: NSRect(x: 100, y: 0, width: 50, height: 25))
        self.customPanel?.contentView?.addSubview(concButton)
        let speakButton = SelectionBarCustomButton(title: "speak", frame: NSRect(x: 150, y: 0, width: 50, height: 25))
        self.customPanel?.contentView?.addSubview(speakButton)
         
       
  
        
     //   print("/*")
      

      
    
       // print("*/")
       

   
       
        
        self.mouseEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseUp, .leftMouseDown, .leftMouseDragged, .mouseMoved, .scrollWheel ]) { [weak self] event in
            guard let self = self else { return }
            
    
            
            if event.type == .mouseMoved {
                
                //reply button active/passive
                if(event.locationInWindow.x > 1 && event.locationInWindow.x < 50.0 && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
                    
                    replyButton.isHighlighted = true
                    
                    
                }
                else {
                    replyButton.isHighlighted = false
                }
                
                
                //trans button active/passive
                if(event.locationInWindow.x > 50 && event.locationInWindow.x < 100.0 && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
                    
                    tsButton.isHighlighted = true
                    
                    
                }
                else {
                    tsButton.isHighlighted = false
                }
                
                
                
                //concl button active/passive
                if(event.locationInWindow.x > 100 && event.locationInWindow.x < 150.0 && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
                    
                    concButton.isHighlighted = true
                    
                    
                }
                else {
                    concButton.isHighlighted = false
                }
                
                
                
                //speak button active/passive
                if(event.locationInWindow.x > 150 && event.locationInWindow.x < 200.0 && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
                    
                    speakButton.isHighlighted = true
                    
                    
                }
                else {
                    speakButton.isHighlighted = false
                }
                
                
                
                
            
            }
            
            
           if event.type == .leftMouseDown {
                // Hide the custom panel if it's currently visible
                 clickedArea = event.locationInWindow
 
                self.customPanel?.orderOut(nil)
               
         
                   
            }
            else if event.type == .scrollWheel {
                self.customPanel?.orderOut(nil)
                
            }
          
            else if    event.type == .leftMouseUp && clickedArea != nil {
                
         
                
              

                
                if event.locationInWindow.x -  clickedArea!.x > 20 ||    clickedArea!.x - event.locationInWindow.x > 20 || event.locationInWindow.y -  clickedArea!.y > 20 ||    clickedArea!.y - event.locationInWindow.y > 20 {
                    
                   
                    
             /*if let selectedText = self.runAppleScript(self.getSelectedTextScript) {
                        print("Selected text: \(selectedText)")
                    } else {
                        print("Failed to get selected text")
                    }
            */
                    self.sendGlobalCommandC()
               
               // self.sendGlobalCommandC() //solved tik
                    
                    
                 //   self.simulateCopyKeystroke(wNumber:self.mainFlutterWindow.windowNumber ) //problem
                 
                
                    
                    
                    
                    
                    
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
                }
/*        self.textSelectionObserver = NotificationCenter.default.addObserver(forName: NSTextView.didChangeSelectionNotification, object: AnyObject.self, queue: nil) { [weak self] notification in
 
 
 guard self != nil else {return }
 

 
}*/
    }
    
    
    
    
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


