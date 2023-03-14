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
    let pasteBoard = NSPasteboard.general
    
    
    //

 

    let menuDelegate = NSMenuDelegate.self

    
   /* func copyToClipboard(_ string: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(string, forType: .string)
    }*/

    
    // Set the layer's properties
   
 
    func checkAccess() -> Bool{
       //get the value for accesibility
       let checkOptPrompt = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString
       //set the options: false means it wont ask
       //true means it will popup and ask
       let options = [checkOptPrompt: true]
       //translate into boolean value
       let accessEnabled = AXIsProcessTrustedWithOptions(options as CFDictionary?)

       if accessEnabled == true {
           print("Access Granted")
           //label.stringValue = "Access Granted"
       } else {
           print("Access not allowed")
           //label.placeholderString = "Access not allowed"
           //label.stringValue = "Access not allowed"
       }

       return accessEnabled
   }

    func simulateCopyKeystroke(wNumber : Int) {
        
        print("siml")
        let commandKey = NSEvent.ModifierFlags.command.rawValue
        let cKey = 8 // the virtual keycode for the letter 'c'
        let keyDownEvent = NSEvent.keyEvent(with: .keyDown,
                                           location: NSPoint(x: 0, y: 0),
                                            modifierFlags: NSEvent.ModifierFlags(rawValue: commandKey),
                                            timestamp: 0,
                                            windowNumber: wNumber,
                                            context: nil,
                                            characters: "",
                                            charactersIgnoringModifiers: "",
                                            isARepeat: false,
                                            keyCode: UInt16(cKey))
        let keyUpEvent = NSEvent.keyEvent(with: .keyUp,
                                          location: NSPoint(x: 0, y: 0),
                                          modifierFlags: NSEvent.ModifierFlags(rawValue: commandKey),
                                          timestamp: 0,
                                          windowNumber: wNumber,
                                          context: nil,
                                          characters: "",
                                          charactersIgnoringModifiers: "",
                                          isARepeat: false,
                                          keyCode: UInt16(cKey))
        NSApplication.shared.sendEvent(keyDownEvent!)
        NSApplication.shared.sendEvent(keyUpEvent!)
    }
    
    
    
    
    
    
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        
        
        return false
    }
    
    
    override func applicationDidFinishLaunching(_ notification: Notification) {
        
        WindowSingleton.shared.window = mainFlutterWindow?.contentViewController as! FlutterViewController
        
        
      checkAccess()
        
 
 
        
        
   
  
  /* let checkOptPrompt = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString

      let options = [checkOptPrompt: true]
      let isAppTrusted = AXIsProcessTrustedWithOptions(options as CFDictionary?);
      if(isAppTrusted != true)
      {
          print(  "please allow accessibility API access to this app.");
      }*/
        //
     
   
        //
 
 
        
        
        
        //let prompt = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String
        //let options: NSDictionary = [prompt: true]
        //let appHasPermission = AXIsProcessTrustedWithOptions(options)
        
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
         
       
  
        
        print("/*")
      

      
    
        print("*/")
       


       
        
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
                
         

                //if let menu = NSApplication.shared {
                  //  print(menu.mainMenu?.items)
                                
                                 //let editMenu = menu.item(withTitle: "Edit")
                                 //print(menu.items)
                                 //let copyItem = editMenu?.submenu
                                 //let item = copyItem?.item(withTitle: "Copy")
                                 
                                 //print(item)
                        //     }
        
                
                if event.locationInWindow.x -  clickedArea!.x > 20 ||    clickedArea!.x - event.locationInWindow.x > 20 || event.locationInWindow.y -  clickedArea!.y > 20 ||    clickedArea!.y - event.locationInWindow.y > 20 {
                    
                    
                    
                    
                 
        
                    
                
                    


                 // Check if any text is selected and show the custom panel if necessary
                 
                    
                 //   self.simulateCopyKeystroke(wNumber: event.windowNumber
                   // )
                    
                    
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
        self.textSelectionObserver = NotificationCenter.default.addObserver(forName: NSTextView.didChangeSelectionNotification, object: AnyObject.self, queue: nil) { [weak self] notification in
            
          
            guard let self = self else {return }
            
            //self.pasteBoard.clearContents()
         
            //self.pasteBoard.writeObjects([notification.object])
            
            print("k1")
            print(notification.object!)
            print("k2")
            
        }
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


