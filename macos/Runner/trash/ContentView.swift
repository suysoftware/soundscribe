//
//  ContentView.swift
//  Runner
//
//  Created by ILION INC on 8.03.2023.
//

import Foundation
import SwiftUI
import FlutterMacOS
import Cocoa
import AppKit






struct ContentView: View {
    @State private var textField:String = ""
    let channelName: String = "soundscribe.suy/statusBarChannel"
        
    // Never comes her
    
    var body: some View {
        
        VStack {
            Button("Hızlı Yanıt - TR", action: {
                //let controller : FlutterViewController = WindowSingleton.shared.window
               // let channel = FlutterMethodChannel.init(name: channelName, binaryMessenger: controller.engine.binaryMessenger)
                
        
                ChannelSingleton.shared.channel.invokeMethod("fastAnswerTr", arguments: nil, result: {(r:Any?) -> () in
                       print("fastAnswerTr Calisti");
                           //        print(r.debugDescription);  // Never comes here
                            })
                
        
            })
            Button("Hızlı Yanıt - EN", action: {
                //let controller : FlutterViewController = WindowSingleton.shared.window
                //let channel = FlutterMethodChannel.init(name: channelName, binaryMessenger: controller.engine.binaryMessenger)
                ChannelSingleton.shared.channel.invokeMethod("fastAnswerEn", arguments: nil, result: {(r:Any?) -> () in
                       print("fastAnswerEn Calisti");
                           //        print(r.debugDescription);  // Never comes here
                            })
            })
            Button("ÖZET", action: {
                //let controller : FlutterViewController = WindowSingleton.shared.window
                //let channel = FlutterMethodChannel.init(name: channelName, binaryMessenger: controller.engine.binaryMessenger)
                ChannelSingleton.shared.channel.invokeMethod("fastConclusion", arguments: nil, result: {(r:Any?) -> () in
                       print("fastAnswerEn Calisti");
                           //        print(r.debugDescription);  // Never comes here
                            })

            })

            TextField("Enter something", text: $textField, onCommit: {
                print("text field committed! value: \(textField)")
            })
            Button("Add Individual Task", action: {
                //NSApplication.shared.terminate(self)
            })
            //
            
            //
            Menu("Actions") {
                Button("Duplicate", action: {})
                Button("Rename", action: {})
                Button("Delete…", action: {})
                Menu("Copy") {
                    Button("Copy", action: {} )
                    Button("Copy Formatted", action: {})
                    Button("Copy Library Path", action: {})
                }
            }
            
            Menu {
                Button("Open in Preview", action: {})
            }
                
                label: {
                Text("Mail Hızlı Yanıt")
                Text("Mail - İngilizce ")
                Text("")
                Text("")

            }

            Button("Quit", action: {
                NSApplication.shared.terminate(self)
            })
        }
        .padding()
    }
   
      
      
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        
        ContentView()
    }
}




