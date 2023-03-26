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
    var defaultPanel: NSPanel?
    var toolTipPanel: NSPanel?
    var mouseEventMonitor: Any?
    let pasteboard = NSPasteboard.general
    var counter = 0
    var toolTipIntervalTime = 0.4
    var timer : Timer?


    func toolTipLocationUpdater(whichButton: String){
        
        self.toolTipPanel?.orderOut(nil)
        var toolTipResetRect = NSRect(x: toolTipRect.midX, y: toolTipRect.midY+90, width: toolTipRect.width, height: toolTipRect.height)
        
        let offSetValue = CGFloat(35)
        var toolTipHeight = CGFloat(((toolTipString.count/50)+2)*20)
        
       
        print(toolTipRect.midX)
        
   
        
        
        switch whichButton {
            
            
        case "First":
            print(firstButtonWidth)
            print(CGFloat((firstButtonWidth)))
            toolTipResetRect = NSRect(x: toolTipRect.midX, y: toolTipRect.midY - offSetValue, width: toolTipRect.width, height: toolTipHeight)
        case "Second":
            print(secondButtonWidth)
            print(CGFloat((secondButtonWidth)))
           toolTipResetRect = NSRect(x:toolTipRect.midX+CGFloat((firstButtonWidth)), y: toolTipRect.midY - offSetValue, width: toolTipRect.width, height: toolTipHeight)
        case "Third":
            print(thirdButtonWidth)
            print(CGFloat((thirdButtonWidth)))
            toolTipResetRect = NSRect(x: toolTipRect.midX+CGFloat((firstButtonWidth+secondButtonWidth)), y: toolTipRect.midY - offSetValue, width: toolTipRect.width, height: toolTipHeight)
        case "Forth":
            print(forthButtonWidth)
            print(CGFloat((forthButtonWidth)))
            toolTipResetRect = NSRect(x: toolTipRect.midX+CGFloat((firstButtonWidth+secondButtonWidth+thirdButtonWidth)), y: toolTipRect.midY - offSetValue, width: toolTipRect.width, height: toolTipHeight)
        case "Fifth":
            print(fifthButtonWidth)
            print(CGFloat((fifthButtonWidth)))
            toolTipResetRect = NSRect(x: toolTipRect.midX+CGFloat((firstButtonWidth+secondButtonWidth+thirdButtonWidth+forthButtonWidth)), y: toolTipRect.midY - offSetValue, width: toolTipRect.width, height: toolTipHeight)
        case "Sixth":
            print(sixthButtonWidth)
            print(CGFloat((sixthButtonWidth)))
            toolTipResetRect = NSRect(x: toolTipRect.midX+CGFloat((firstButtonWidth+secondButtonWidth+thirdButtonWidth+forthButtonWidth+fifthButtonWidth)), y: toolTipRect.midY - offSetValue, width: toolTipRect.width, height: toolTipHeight)
        
        default:
            toolTipResetRect = NSRect(x: toolTipRect.midX, y: toolTipRect.midY-90, width: toolTipRect.width, height: toolTipHeight)
        
        }
        
        
        
       
        
        self.toolTipPanel = ToolTipPanel(contentRect: toolTipResetRect, styleMask: styleMask, backing: .buffered, defer: false)

        self.toolTipPanel!.orderFront(nil)
    }


  
    func whichPlatformActive() -> String {
            // Get the app that currently has the focus.
       if let frontApp = NSWorkspace.shared.frontmostApplication{
           if chromium_variants.contains(frontApp.localizedName!){
               if let selectedText = runAppTitleAppleScript(scriptTextGetterForBrowsers(frontApp.localizedName!)) {
  
                   return webNameTrimmer(selectedText)
                      } else {
                          return "default"
                      }
           }
           else {
               if(frontApp.bundleIdentifier!.starts(with: "com.apple.") ){
                   return desktopNameTrimmer(source: frontApp.bundleIdentifier!, isApple: true)
                   
               }
               else{
                   
                   return frontApp.localizedName!.lowercased()
               }
               

         }
       }
        else {
            return "default"
        }
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
        
  

        
        self.mouseEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseUp, .leftMouseDown, .leftMouseDragged, .mouseMoved, .scrollWheel ]) { [weak self] event in
            guard let self = self else { return }
            
    
            
            if event.type == .mouseMoved {
                
       
                if(event.locationInWindow.x > CGFloat(firstButtonX+1) && event.locationInWindow.x < CGFloat(secondButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
 
                   firstSelectionBarButton.isHighlighted = true
                
                
                   
                    updateAllToolTipAnimate(whichButton: "First", whichOrder: true)
                    self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.toolTipIntervalTime), repeats: false) { (_) in
                        if(animateFirstToolTip == true ){
                            
                            self.toolTipLocationUpdater(whichButton: "First")
                            
                     updateAllToolTipAnimate(whichButton: "First", whichOrder: false)
                            
                        }
                      
                       }

                    
                }
                else {
                  firstSelectionBarButton.isHighlighted = false
                    
                    if((event.locationInWindow.x > CGFloat(secondButtonX) && event.locationInWindow.x < CGFloat(thirdButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ) || (event.locationInWindow.x > CGFloat(thirdButtonX) && event.locationInWindow.x < CGFloat(forthButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ) || (event.locationInWindow.x > CGFloat(forthButtonX) && event.locationInWindow.x < CGFloat(fifthButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25) || (event.locationInWindow.x > CGFloat(fifthButtonX) && event.locationInWindow.x < CGFloat(sixthButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25) || (event.locationInWindow.x > CGFloat(sixthButtonX) && event.locationInWindow.x < CGFloat(sixthButtonX+sixthButtonWidth) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ) ){
                        
                    }
                    else {
                        
                 updateAllToolTipAnimate(whichButton: "ALL", whichOrder: false)
                        self.toolTipPanel?.orderOut(nil)
                    }
                 
                    
                    
                    
                    
                    
                    
                }
                //second button active/passive
                if(event.locationInWindow.x > CGFloat(secondButtonX) && event.locationInWindow.x < CGFloat(thirdButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
                    
                  secondSelectionBarButton.isHighlighted = true
                   updateAllToolTipAnimate(whichButton: "Second", whichOrder: true)
                   
                    
                   
                    self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.toolTipIntervalTime), repeats: false) { (_) in
                        if(animateSecondToolTip == true ){
                            
                            self.toolTipLocationUpdater(whichButton: "Second")
                        updateAllToolTipAnimate(whichButton: "Second", whichOrder: false)
                        }
                      
                       }
                    
                
                    
                    
                }
                else {
                   secondSelectionBarButton.isHighlighted = false
                }
                //third button active/passive
                if(event.locationInWindow.x > CGFloat(thirdButtonX) && event.locationInWindow.x < CGFloat(forthButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
                   thirdSelectionBarButton.isHighlighted = true
               updateAllToolTipAnimate(whichButton: "Third", whichOrder: true)
                   
                    self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.toolTipIntervalTime), repeats: false) { (_) in
                        if(animateThirdToolTip == true ){
                            
                            self.toolTipLocationUpdater(whichButton: "Third")
                          updateAllToolTipAnimate(whichButton: "Third", whichOrder: false)
                        }
                      
                       }
                }
                else {
                 thirdSelectionBarButton.isHighlighted = false
                }
                //forth button active/passive
                if(event.locationInWindow.x > CGFloat(forthButtonX) && event.locationInWindow.x < CGFloat(fifthButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
              forthSelectionBarButton.isHighlighted = true
                  updateAllToolTipAnimate(whichButton: "Forth", whichOrder: true)
                   
                    self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.toolTipIntervalTime), repeats: false) { (_) in
                        if(animateForthToolTip == true ){
                            
                            self.toolTipLocationUpdater(whichButton: "Forth")
                            updateAllToolTipAnimate(whichButton: "Forth", whichOrder: false)
                        }
                      
                       }
                }
                else {
                 forthSelectionBarButton.isHighlighted = false
                }
                if(event.locationInWindow.x > CGFloat(fifthButtonX) && event.locationInWindow.x < CGFloat(sixthButtonX) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
                    
              fifthSelectionBarButton.isHighlighted = true
                  updateAllToolTipAnimate(whichButton: "Fifth", whichOrder: true)
                   
                    self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.toolTipIntervalTime), repeats: false) { (_) in
                        if(animateFifthToolTip == true ){
                            
                            self.toolTipLocationUpdater(whichButton: "Fifth")
                           updateAllToolTipAnimate(whichButton: "Fifth", whichOrder: false)

                        }
                      
                       }
                }
                else {
                 fifthSelectionBarButton.isHighlighted = false
                }
                if(event.locationInWindow.x > CGFloat(sixthButtonX) && event.locationInWindow.x < CGFloat(sixthButtonX+sixthButtonWidth) && event.locationInWindow.y > 0 && event.locationInWindow.y < 25 ){
              sixthSelectionBarButton.isHighlighted = true
                    
              updateAllToolTipAnimate(whichButton: "Sixth", whichOrder: true)

                   
                    self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.toolTipIntervalTime), repeats: false) { (_) in
                        if(animateSixthToolTip == true ){
                            
                            self.toolTipLocationUpdater(whichButton: "Sixth")
                           updateAllToolTipAnimate(whichButton: "Sixth", whichOrder: false)
                        }
                      
                       }
                }
                else {
                 sixthSelectionBarButton.isHighlighted = false
                }
            }
            if event.type == .leftMouseDragged {
                 // Hide the custom panel if it's currently visible
            
                 self.customPanel?.orderOut(nil)
                self.toolTipPanel?.orderOut(nil)
                
             }

           if event.type == .leftMouseDown {
                // Hide the custom panel if it's currently visible
                 clickedArea = event.locationInWindow
           
                self.customPanel?.orderOut(nil)
               self.toolTipPanel?.orderOut(nil)
               
            }
            else if event.type == .scrollWheel {
                self.customPanel?.orderOut(nil)
                self.toolTipPanel?.orderOut(nil)
                
            }
          
            else if    event.type == .leftMouseUp && clickedArea != nil {
                
           
        
                self.customPanel?.orderOut(nil)
                
            self.customPanel = DefaultPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
                
                focusedPanelExcel(self.whichPlatformActive())

                
                
                
                
                if event.locationInWindow.x -  clickedArea!.x > 20 ||    clickedArea!.x - event.locationInWindow.x > 20 || event.locationInWindow.y -  clickedArea!.y > 20 ||    clickedArea!.y - event.locationInWindow.y > 20 {

                  sendGlobalCommandC()
                        if  let customPanel = self.customPanel {
 
                            // Calculate the location of the mouse click in screen coordinates
                            let mouseLocation = NSEvent.mouseLocation
                            let panelOrigin = NSPoint(x: mouseLocation.x - panelRect.width*0.6 , y: mouseLocation.y + panelRect.height*0.2 )
                            let screenFrame = NSScreen.main?.frame ?? NSRect.zero
                            
                            // Check if the panel would be offscreen and adjust if necessary
                            var panelFrame = NSRect(origin: panelOrigin, size: panelRect.size)
                            var toolTipFrame = NSRect(origin: panelOrigin, size: toolTipRect.size)
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
                            toolTipRect = toolTipFrame
                            
                            
                           
                            customPanel.makeKeyAndOrderFront(nil)
                        }
                        
                    
                  
                    
                 
                    
                   
              
             }
         }
                }
    }
}
    
    

