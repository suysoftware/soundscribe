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

var widthValue = 10

var firstButtonWidth = firstSelectionBarButton.title.count*widthValue
var firstButtonX = 0
var secondButtonWidth = secondSelectionBarButton.title.count*widthValue
var secondButtonX = firstSelectionBarButton.title.count*widthValue
var thirdButtonWidth = thirdSelectionBarButton.title.count*widthValue
var thirdButtonX = firstSelectionBarButton.title.count*widthValue + secondSelectionBarButton.title.count*widthValue
var forthButtonWidth = forthSelectionBarButton.title.count*widthValue
var forthButtonX = firstSelectionBarButton.title.count*widthValue + secondSelectionBarButton.title.count*widthValue + thirdSelectionBarButton.title.count*widthValue
var fifthButtonWidth = fifthSelectionBarButton.title.count*widthValue
var fifthButtonX = firstSelectionBarButton.title.count*widthValue + secondSelectionBarButton.title.count*widthValue + thirdSelectionBarButton.title.count*widthValue + forthSelectionBarButton.title.count*widthValue
var sixthButtonWidth = sixthSelectionBarButton.title.count*widthValue
var sixthButtonX = firstSelectionBarButton.title.count*widthValue + secondSelectionBarButton.title.count*widthValue + thirdSelectionBarButton.title.count*widthValue + forthSelectionBarButton.title.count*widthValue + fifthSelectionBarButton.title.count*widthValue



var panelRect = NSRect(x: 0, y: 0, width: (firstSelectionBarButton.title.count*widthValue+secondSelectionBarButton.title.count*widthValue+thirdSelectionBarButton.title.count*widthValue+forthSelectionBarButton.title.count*widthValue+fifthSelectionBarButton.title.count*widthValue+sixthSelectionBarButton.title.count*widthValue), height: 25)
var styleMask = NSWindow.StyleMask(arrayLiteral:[.borderless, .nonactivatingPanel,] )



func focusedPanelExcel(_ source: String) {
    
    firstSelectionBarButton.title = "Default1"
    secondSelectionBarButton.title = "Default2"
    thirdSelectionBarButton.title = "Default3"
    forthSelectionBarButton.title = "Default4"
    fifthSelectionBarButton.title = "Default5"
    sixthSelectionBarButton.title = "Talk"
    changerFF()
    
    result!.rows.forEach { row in
       
        
        let leftString = row[1]!
        
        if leftString as! String == source {
            
            
           platformId = row.index
            
            
            firstSelectionBarButton.title = row[4] as! String
            secondSelectionBarButton.title = row[4] as! String
            thirdSelectionBarButton.title = row[4] as! String
            forthSelectionBarButton.title = row[4] as! String
            fifthSelectionBarButton.title = row[4] as! String
            sixthSelectionBarButton.title = row[4] as! String
          
            changerFF()
       
        }
      /*  else {
       
            firstSelectionBarButton.title = "aa1"
            secondSelectionBarButton.title = "aa2"
            thirdSelectionBarButton.title = "aa3"
            forthSelectionBarButton.title = "aa4"
            fifthSelectionBarButton.title = "aa5"
            sixthSelectionBarButton.title = "aa6"
          
            changerFF()
            
        }*/
        
  
        
    }
    

}


func buttonActionGetter(_ buttonActionLine: Int, platformId: Int) -> String {
    
    
   let buttonAction = result!.rows[platformId][buttonActionLine] as! String
    return buttonAction
    
    
  
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
    panelRect = NSRect(x: 0, y: 0, width: (firstSelectionBarButton.title.count*widthValue+secondSelectionBarButton.title.count*widthValue+thirdSelectionBarButton.title.count*widthValue+forthSelectionBarButton.title.count*widthValue+fifthSelectionBarButton.title.count*widthValue+sixthSelectionBarButton.title.count*widthValue), height: 25)
    
    firstButtonWidth = firstSelectionBarButton.title.count*widthValue
    firstButtonX = 0
    secondButtonWidth = secondSelectionBarButton.title.count*widthValue
    secondButtonX = firstSelectionBarButton.title.count*widthValue
    thirdButtonWidth = thirdSelectionBarButton.title.count*widthValue
    thirdButtonX = firstSelectionBarButton.title.count*widthValue + secondSelectionBarButton.title.count*widthValue
    forthButtonWidth = forthSelectionBarButton.title.count*widthValue
    forthButtonX = firstSelectionBarButton.title.count*widthValue + secondSelectionBarButton.title.count*widthValue + thirdSelectionBarButton.title.count*widthValue
    fifthButtonWidth = fifthSelectionBarButton.title.count*widthValue
    fifthButtonX = firstSelectionBarButton.title.count*widthValue + secondSelectionBarButton.title.count*widthValue + thirdSelectionBarButton.title.count*widthValue + forthSelectionBarButton.title.count*widthValue
    sixthButtonWidth = sixthSelectionBarButton.title.count*widthValue
    sixthButtonX = firstSelectionBarButton.title.count*widthValue + secondSelectionBarButton.title.count*widthValue + thirdSelectionBarButton.title.count*widthValue + forthSelectionBarButton.title.count*widthValue + fifthSelectionBarButton.title.count*widthValue

    
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
