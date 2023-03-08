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
    

    
   
    func triggerToTest() {
        
        
        
        DispatchQueue.main.async {
          let CHANNEL_SENDER_NAME = "soundscribe.suy/methodTest"
          let flutterViewController = FlutterViewController.init()
          let channelSenderTest = FlutterMethodChannel(name: CHANNEL_SENDER_NAME, binaryMessenger: flutterViewController.engine.binaryMessenger)
            
            
        channelSenderTest.invokeMethod("onFinish", arguments: nil)
       
        }
        //channelSenderTest.invokeMethod("onFinish", arguments: nil, result: {(r:Any?) -> () in
          //     print("buraya geldi");
            //               print(r.debugDescription);  // Never comes here
              //      })
     
   }
    


    
    
    // Never comes her
    
    var body: some View {
        VStack {
            Button("Click me!", action: {
                print(NSApplication.shared.isFullKeyboardAccessEnabled)
                print("clicked!")
                
                
        
            })

            TextField("Enter something", text: $textField, onCommit: {
                print("text field committed! value: \(textField)")
            })

            Menu {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
                Text("Item 4")
            } label: {
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
