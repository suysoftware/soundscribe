//
//  FocusedPanelGetter.swift
//  Runner
//
//  Created by ILION INC on 16.03.2023.
//

import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI
import TabularData





let url = Bundle.main.url(forResource: "platforms_file", withExtension: "csv")!
let result = try? DataFrame(contentsOfCSVFile: url)



var firstButtonWidth = firstSelectionBarButton.title.count*20
var firstButtonX = 0
var secondButtonWidth = secondSelectionBarButton.title.count*20
var secondButtonX = firstSelectionBarButton.title.count*20
var thirdButtonWidth = thirdSelectionBarButton.title.count*20
var thirdButtonX = firstSelectionBarButton.title.count*20 + secondSelectionBarButton.title.count*20
var forthButtonWidth = forthSelectionBarButton.title.count*20
var forthButtonX = firstSelectionBarButton.title.count*20 + secondSelectionBarButton.title.count*20 + thirdSelectionBarButton.title.count*20
var fifthButtonWidth = fifthSelectionBarButton.title.count*20
var fifthButtonX = firstSelectionBarButton.title.count*20 + secondSelectionBarButton.title.count*20 + thirdSelectionBarButton.title.count*20 + forthSelectionBarButton.title.count*20
var sixthButtonWidth = sixthSelectionBarButton.title.count*20
var sixthButtonX = firstSelectionBarButton.title.count*20 + secondSelectionBarButton.title.count*20 + thirdSelectionBarButton.title.count*20 + forthSelectionBarButton.title.count*20 + fifthSelectionBarButton.title.count*20



var panelRect = NSRect(x: 0, y: 0, width: (firstSelectionBarButton.title.count*20+secondSelectionBarButton.title.count*20+thirdSelectionBarButton.title.count*20+forthSelectionBarButton.title.count*20+fifthSelectionBarButton.title.count*20+sixthSelectionBarButton.title.count*20), height: 25)
var styleMask = NSWindow.StyleMask(arrayLiteral:[.borderless, .nonactivatingPanel,] )



func focusedPanelExcel(_ source: String) {
    
    
    result!.rows.forEach { row in
        let leftString = row[1]!
        
        if leftString as! String == source {
            
            
            
            firstSelectionBarButton.title = row[4] as! String
            secondSelectionBarButton.title = row[4] as! String
            thirdSelectionBarButton.title = row[4] as! String
            forthSelectionBarButton.title = row[4] as! String
            fifthSelectionBarButton.title = row[4] as! String
            sixthSelectionBarButton.title = row[4] as! String
          
            changerFF()
        }
        
  
        
    }
}


func changerFF() {

    
    
    /*result!.rows.forEach { row in
        let leftString = row[1]!
        
        if leftString as! String == "Slack" {
            
            print("aha")
        }
        
        print(leftString)
    }
    */
    panelRect = NSRect(x: 0, y: 0, width: (firstSelectionBarButton.title.count*20+secondSelectionBarButton.title.count*20+thirdSelectionBarButton.title.count*20+forthSelectionBarButton.title.count*20+fifthSelectionBarButton.title.count*20+sixthSelectionBarButton.title.count*20), height: 25)
    
    firstButtonWidth = firstSelectionBarButton.title.count*20
    firstButtonX = 0
    secondButtonWidth = secondSelectionBarButton.title.count*20
    secondButtonX = firstSelectionBarButton.title.count*20
    thirdButtonWidth = thirdSelectionBarButton.title.count*20
    thirdButtonX = firstSelectionBarButton.title.count*20 + secondSelectionBarButton.title.count*20
    forthButtonWidth = forthSelectionBarButton.title.count*20
    forthButtonX = firstSelectionBarButton.title.count*20 + secondSelectionBarButton.title.count*20 + thirdSelectionBarButton.title.count*20
    fifthButtonWidth = fifthSelectionBarButton.title.count*20
    fifthButtonX = firstSelectionBarButton.title.count*20 + secondSelectionBarButton.title.count*20 + thirdSelectionBarButton.title.count*20 + forthSelectionBarButton.title.count*20
    sixthButtonWidth = sixthSelectionBarButton.title.count*20
    sixthButtonX = firstSelectionBarButton.title.count*20 + secondSelectionBarButton.title.count*20 + thirdSelectionBarButton.title.count*20 + forthSelectionBarButton.title.count*20 + fifthSelectionBarButton.title.count*20

    
    //self.contentView?.frame = NSRect(x: 0, y: 0, width: 300, height: 35)
   
    
    

    
    
    firstSelectionBarButton.frame = NSRect(x: firstButtonX, y: 0, width: firstButtonWidth, height:25)
    secondSelectionBarButton.frame = NSRect(x: secondButtonX, y: 0, width: secondButtonWidth, height:25)
    thirdSelectionBarButton.frame = NSRect(x: thirdButtonX, y: 0, width: thirdButtonWidth, height:25)
    forthSelectionBarButton.frame = NSRect(x: forthButtonX, y: 0, width: forthButtonWidth, height:25)
    fifthSelectionBarButton.frame = NSRect(x: fifthButtonX, y: 0, width: fifthButtonWidth, height:25)
    sixthSelectionBarButton.frame = NSRect(x: sixthButtonX, y: 0, width: sixthButtonWidth, height:25)
}






/*import Foundation
 import AppKit



 func focusedPanelGetter(_ source: String, nsRect: NSRect) -> NSPanel {
     
     switch source {
         
         
     case "com.apple.dt.Xcode":
         return XcodePanel(contentRect: nsRect, styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
     case "com.hnc.Discord":
         return DiscordPanel(contentRect: nsRect, styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
     case "com.spotify.client":
         return SelectionBarPanel(contentRect: nsRect, styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
     default:
         return SelectionBarPanel(contentRect: nsRect, styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
     }
 }
*/
