import Cocoa
import TabularData
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
    var customPanel: NSPanel?
    var xcodePanel: NSPanel?
    var discordPanel: NSPanel?
    var defaultPanel: NSPanel?
    var mouseEventMonitor: Any?
    let pasteboard = NSPasteboard.general


    let chromium_variants = ["Google Chrome", "Chromium", "Opera", "Vivaldi", "Brave Browser", "Microsoft Edge","Safari","Tor Browser","Yandex"]


    func runAppTitleAppleScript(_ source: String) -> String? {
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
    
    
    func getClipboardItem() -> String? {
        guard let string = NSPasteboard.general.string(forType: .string) else {
            // The clipboard is empty or does not contain a string
            return nil
        }
        // Found a string item on the clipboard
        return string
    }
  
    func whichPlatformActive() -> String {
            // Get the app that currently has the focus.
       if let frontApp = NSWorkspace.shared.frontmostApplication{
           if chromium_variants.contains(frontApp.localizedName!){
               if let selectedText = self.runAppTitleAppleScript(scriptTextGetterForBrowsers(frontApp.localizedName!)) {
                   
                   let repOc = selectedText.replacingOccurrences(of:"https://", with: "")
                   let index = repOc.firstIndex(of: "/") ?? repOc.endIndex
                   let result = repOc[..<index]
                   //copyToClipboard(String(result))
                   return String(result)
                      } else {
                          return "default"
                      }
           }
           else {
              // copyToClipboard(frontApp.bundleIdentifier!)
               return frontApp.bundleIdentifier!
         }
       }
        else {
            return "default"
        }
        }

    func copyToClipboard(_ string: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(string, forType: .string)
    }
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }

    override func applicationDidFinishLaunching(_ notification: Notification) {
        
        WindowSingleton.shared.window = mainFlutterWindow?.contentViewController as! FlutterViewController
        let controller : FlutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
        let channel = FlutterMethodChannel.init(name: channelName, binaryMessenger: controller.engine.binaryMessenger)
        ChannelSingleton.shared.channel = channel
        var clickedArea : NSPoint?
        let statusBarContent = StatusBarContent()
        let mainExtraView = NSHostingView(rootView: statusBarContent)
        mainExtraView.frame =  NSRect(x: 0, y: 0, width: 250, height: 300)
        statusBarExtra = StatusBarExtraController(mainExtraView)
        
        
       
       
       
        
        
        channel.setMethodCallHandler({ (_ call: FlutterMethodCall, _ result: FlutterResult) -> Void in
            
            if ("getAppIntents" == call.method) {
                result("test")
                return
            }
            if ("showUrlImage" == call.method) {
               
           
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
        
    
        
        // Panel Variables
       
        
        

        
        self.mouseEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseUp, .leftMouseDown, .leftMouseDragged, .mouseMoved, .scrollWheel ]) { [weak self] event in
            guard let self = self else { return }
            
    
            
            if event.type == .mouseMoved {
            
            
             
                
                //first button active/passive
                if(event.locationInWindow.x > CGFloat(firstButtonX+1) && event.locationInWindow.x < CGFloat(secondButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
 
                   firstSelectionBarButton.isHighlighted = true
                }
                else {
                  firstSelectionBarButton.isHighlighted = false
                }
                //second button active/passive
                if(event.locationInWindow.x > CGFloat(secondButtonX) && event.locationInWindow.x < CGFloat(thirdButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
                    
                  secondSelectionBarButton.isHighlighted = true
                }
                else {
                   secondSelectionBarButton.isHighlighted = false
                }
                //third button active/passive
                if(event.locationInWindow.x > CGFloat(thirdButtonX) && event.locationInWindow.x < CGFloat(forthButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
                   thirdSelectionBarButton.isHighlighted = true
                }
                else {
                 thirdSelectionBarButton.isHighlighted = false
                }
                //forth button active/passive
                if(event.locationInWindow.x > CGFloat(forthButtonX) && event.locationInWindow.x < CGFloat(fifthButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
              forthSelectionBarButton.isHighlighted = true
                }
                else {
                 forthSelectionBarButton.isHighlighted = false
                }
                if(event.locationInWindow.x > CGFloat(fifthButtonX) && event.locationInWindow.x < CGFloat(sixthButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
              fifthSelectionBarButton.isHighlighted = true
                }
                else {
                 fifthSelectionBarButton.isHighlighted = false
                }
                if(event.locationInWindow.x > CGFloat(sixthButtonX) && event.locationInWindow.x < CGFloat(sixthButtonX+sixthButtonWidth) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
              sixthSelectionBarButton.isHighlighted = true
                }
                else {
                 sixthSelectionBarButton.isHighlighted = false
                }
            }
            if event.type == .leftMouseDragged {
                 // Hide the custom panel if it's currently visible
            
                 self.customPanel?.orderOut(nil)
                
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
                
           
        
                self.customPanel?.orderOut(nil)
                
            self.customPanel = DefaultPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
                
                focusedPanelExcel(self.whichPlatformActive())
                
                
                
                
                
                
                if event.locationInWindow.x -  clickedArea!.x > 20 ||    clickedArea!.x - event.locationInWindow.x > 20 || event.locationInWindow.y -  clickedArea!.y > 20 ||    clickedArea!.y - event.locationInWindow.y > 20 {
                    
          
                    
                    
                    self.sendGlobalCommandC()
                        if  let customPanel = self.customPanel {
                            
                       
                         

                            // Calculate the location of the mouse click in screen coordinates
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
    }
}
    
    

