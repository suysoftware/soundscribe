import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI



@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    let channelName: String = "soundscribe.suy/methods"
    let EVENT_CHANNEL_NAME = "soundscribe.suy/intents/events"
    
    var statusBar: StatusBarController?

    
    
   
    
    
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        
        
        return false
    }
    
    
    override func applicationDidFinishLaunching(_ notification: Notification) {
        
        
      
        
        let controller : FlutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
        let channel = FlutterMethodChannel.init(name: channelName, binaryMessenger: controller.engine.binaryMessenger)
        
        //let channelSender = FlutterMethodChannel.init(name: CHANNEL_SENDER_NAME, binaryMessenger: controller.engine.binaryMessenger)
        
        let contentView = ContentView()
        let mainView = NSHostingView(rootView: contentView)
        mainView.frame =  NSRect(x: 0, y: 0, width: 300, height: 200)
        statusBar = StatusBarController(mainView)

        
        
        channel.setMethodCallHandler({ (_ call: FlutterMethodCall, _ result: FlutterResult) -> Void in
            
            if ("getAppIntents" == call.method) {
                    result("hadi iyisin")
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
        
    
    }
    
    
}


