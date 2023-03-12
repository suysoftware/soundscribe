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










struct StatusBarContent: View {
    @State private var textField:String = ""
    let channelName: String = "soundscribe.suy/statusBarChannel"
    var resultText: String = "A    "

    @GestureState private var isDetectingLongPress = false
    @State private var completedLongPress = false

    
    
    
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 0.02)
               .updating($isDetectingLongPress) { currentState, gestureState,
                       transaction in
                   gestureState = currentState
                   transaction.animation = Animation.easeIn(duration: 0.0)
                   print("basladi")
               }
               .onEnded { finished in
                   self.completedLongPress = finished
                   print("bitir")
               }
       }


    
       
   

    // Never comes her
    
    var body: some View {

        
        VStack {
            
            HStack(alignment: .center) {
                
             
                Button("Hızlı Yanıt - TR", action: {
                    //let controller : FlutterViewController = WindowSingleton.shared.window
                   // let channel = FlutterMethodChannel.init(name: channelName, binaryMessenger: controller.engine.binaryMessenger)
                    
            
                   /* ChannelSingleton.shared.channel.invokeMethod("fastAnswerTr", arguments: nil, result: {(r:Any?) -> () in
                           print("fastAnswerTr Calisti");
                        
                        FirstTaskSingleton.instance.SetData(value: false)
                        print(r.debugDescription);  // Never comes here
                                })*/
                    
            
                }).accessibilityAddTraits(.isHeader)
                
                
            }
            
            
           
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
            
            
            
            //
            Circle()
                .fill(self.isDetectingLongPress ?
                    Color.red :
                    (self.completedLongPress ? Color.green : Color.blue))
                .frame(width: 100, height: 100, alignment: .center)
                .gesture(longPress)
 
            //
            TextField("Enter something", text: $textField, onCommit: {
                
                print("text field committed! value: \(textField)")
            })
            
            
            
            HStack(alignment: .center) {
                
                
                Button("Add Individual Task", action: {
                    print(textField)
                    //NSApplication.shared.terminate(self)
                })
                Button("Send Task", action: {
                    
                    ChannelSingleton.shared.channel.invokeMethod("fastConclusion", arguments: nil, result: {(r:Any?) -> () in
                           print("fastAnswerEn Calisti");
                               //        print(r.debugDescription);  // Never comes here
                                })
                })
                
                
                
                }
            //
            
            //
          /*  Menu("Actions") {
                Button("Duplicate", action: {
                    print("aaa")
                })
                Button("Rename", action: {
                    print("aaa")
                })
                Button("Delete…", action: {
                    print("aaa")
                })
                Menu("Copy") {
                    Button("Copy", action: {} )
                    Button("Copy Formatted", action: {})
                    Button("Copy Library Path", action: {})
                }
            }*/
            
            Menu {
                Button("Open in Preview", action: {})
            }
                
                label: {
                Text("Individual 1")
                Text("Mail - İngilizce ")
                Text("")
                Text("")

            }

            /*Button("Quit", action: {
                NSApplication.shared.terminate(self)
            })*/
        }
        .padding()
    }
   
      
      
}

struct StatusBarContent_Previews: PreviewProvider {

    static var previews: some View {
        
        StatusBarContent()
    }
}
