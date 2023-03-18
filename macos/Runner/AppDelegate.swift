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
    
    func getClipboardItem() -> String? {
        guard let string = NSPasteboard.general.string(forType: .string) else {
            // The clipboard is empty or does not contain a string
            return nil
        }
        // Found a string item on the clipboard
        return string
    }
    func sendGlobalCommandCForAppDelegate() -> Bool{
        
        
       
        
        
        
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
               
           

                let strURL = "https://oaidalleapiprodscus.blob.core.windows.net/private/org-ur1r8htH8m8O4WqadZg771wj/user-b1echiaFvB5gGcZoZPLW4b4V/img-QAzp8lGBOCz0ysOBCSnBHDcO.png?st=2023-03-18T18%3A14%3A06Z&se=2023-03-18T20%3A14%3A06Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-03-18T00%3A39%3A59Z&ske=2023-03-19T00%3A39%3A59Z&sks=b&skv=2021-08-06&sig=tcMz9mvVYILHkWcrlUnONG5wKCSSqYrle2zi7x4tR58%3D"
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
        let panelRect = NSRect(x: 0, y: 0, width: 200, height: 25)
        let styleMask = NSWindow.StyleMask(arrayLiteral:[.borderless, .nonactivatingPanel,] )
        
        
       // self.customPanel = DefaultPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
        //Panels
        /*
        self.xcodePanel = XcodePanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
        self.customPanel = DefaultPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
        self.discordPanel = DiscordPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
        self.defaultPanel = DefaultPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
       */
        
        
        
        // Panels Level
  
     /*   self.customPanel?.level = .floating
        self.discordPanel?.level = .floating
        self.defaultPanel?.level = .floating
        self.xcodePanel?.level = .floating*/
        
        
   /*
        //default buttons add to default panel
        let platformDefault = "default"
        let firstDefaultButton = platformFirstButtonGetter(platformDefault)
        //self.customPanel?.contentView?.addSubview(firstDefaultButton)
        self.customPanel?.contentView?.addSubview(firstTestButton)
        let secondDefaultButton = platformSecondButtonGetter(platformDefault)
        //self.customPanel?.contentView?.addSubview(secondDefaultButton)
        self.customPanel?.contentView?.addSubview(secondTestButton)
        let thirdDefaultButton = platformThirdButtonGetter(platformDefault)
        //self.customPanel?.contentView?.addSubview(thirdDefaultButton)
        self.customPanel?.contentView?.addSubview(thirdTestButton)
        let forthDefaultButton = platformForthButtonGetter(platformDefault)
        //self.customPanel?.contentView?.addSubview(forthDefaultButton)
        self.customPanel?.contentView?.addSubview(forthTestButton)
         
        
        /*
        self.defaultPanel?.contentView?.addSubview(firstDefaultButton)
        self.defaultPanel?.contentView?.addSubview(secondDefaultButton)
        self.defaultPanel?.contentView?.addSubview(thirdDefaultButton)
        self.defaultPanel?.contentView?.addSubview(forthDefaultButton)
        */
        self.defaultPanel?.contentView?.addSubview(firstTestButton)
        self.defaultPanel?.contentView?.addSubview(secondTestButton)
        self.defaultPanel?.contentView?.addSubview(thirdTestButton)
        self.defaultPanel?.contentView?.addSubview(forthTestButton)
        
        
        //xcode buttons add to xcode panel
        let platformXcode = "com.apple.dt.Xcode"
        let firstXcodeButton = platformFirstButtonGetter(platformXcode)
        self.xcodePanel?.contentView?.addSubview(firstXcodeButton)
        let secondXcodeButton = platformSecondButtonGetter(platformXcode)
        self.xcodePanel?.contentView?.addSubview(secondXcodeButton)
        let thirdXcodeButton = platformThirdButtonGetter(platformXcode)
        self.xcodePanel?.contentView?.addSubview(thirdXcodeButton)
        let forthXcodeButton = platformForthButtonGetter(platformXcode)
        self.xcodePanel?.contentView?.addSubview(forthXcodeButton)
  
        
        //discord buttons add to discord panel
        let platformDiscord = "com.hnc.Discord"
        let firstDiscordButton = platformFirstButtonGetter(platformDiscord)
        self.discordPanel?.contentView?.addSubview(firstDiscordButton)
        let secondDiscordButton = platformSecondButtonGetter(platformDiscord)
        self.discordPanel?.contentView?.addSubview(secondDiscordButton)
        let thirdDiscordButton = platformThirdButtonGetter(platformDiscord)
        self.discordPanel?.contentView?.addSubview(thirdDiscordButton)
        let forthDiscordButton = platformForthButtonGetter(platformDiscord)
        self.discordPanel?.contentView?.addSubview(forthDiscordButton)
 
   */
       
        
        self.mouseEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseUp, .leftMouseDown, .leftMouseDragged, .mouseMoved, .scrollWheel ]) { [weak self] event in
            guard let self = self else { return }
            
    
            
            if event.type == .mouseMoved {
             
                if NSCursor.currentSystem?.hotSpot.x == NSCursor.contextualMenu.hotSpot.x {
                    print("aga")
                }
             
                
                //first button active/passive
               if(event.locationInWindow.x > 1 && event.locationInWindow.x < 50.0 && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
 
                   firstSelectionBarButton.isHighlighted = true
                }
                else {
                  firstSelectionBarButton.isHighlighted = false
                }
                //second button active/passive
                if(event.locationInWindow.x > 50 && event.locationInWindow.x < 100.0 && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
                    
                  secondSelectionBarButton.isHighlighted = true
                }
                else {
                   secondSelectionBarButton.isHighlighted = false
                }
                //third button active/passive
                if(event.locationInWindow.x > 100 && event.locationInWindow.x < 150.0 && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
                   thirdSelectionBarButton.isHighlighted = true
                }
                else {
                 thirdSelectionBarButton.isHighlighted = false
                }
                //forth button active/passive
                if(event.locationInWindow.x > 150 && event.locationInWindow.x < 200.0 && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
              forthSelectionBarButton.isHighlighted = true
                }
                else {
                 forthSelectionBarButton.isHighlighted = false
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
                
                self.customPanel = focusedPanelGetter(self.whichPlatformActive())
                if event.locationInWindow.x -  clickedArea!.x > 20 ||    clickedArea!.x - event.locationInWindow.x > 20 || event.locationInWindow.y -  clickedArea!.y > 20 ||    clickedArea!.y - event.locationInWindow.y > 20 {
                    
             
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
    
    

