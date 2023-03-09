import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI



@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    let channelName: String = "soundscribe.suy/statusBarChannel"
    var statusBar: StatusBarController?
    var statusBarExtra: StatusBarExtraController?

    
    
   
    
    
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        
        
        return false
    }
    
    
    override func applicationDidFinishLaunching(_ notification: Notification) {
        
        WindowSingleton.shared.window = mainFlutterWindow?.contentViewController as! FlutterViewController
        
      
        
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
        
    
    }
    
    
}


