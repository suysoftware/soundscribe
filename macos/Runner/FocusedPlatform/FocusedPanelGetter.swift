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


let url = Bundle.main.url(forResource: "platform_file", withExtension: "csv")!
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
    
    let focusedPlatform = ">"+source+"<"
    
  
    firstSelectionBarButton.title = result!.rows[0][7] as! String
    secondSelectionBarButton.title = result!.rows[0][10] as! String
    thirdSelectionBarButton.title = result!.rows[0][13] as! String
    forthSelectionBarButton.title = result!.rows[0][16] as! String
    fifthSelectionBarButton.title = result!.rows[0][19] as! String
    sixthSelectionBarButton.title = result!.rows[0][22] as! String
    objectSizeUpdater()
    
    result!.rows.forEach { row in
       
        let leftString = row[3]!
        let platformName = (leftString as! String).lowercased()

        if platformName.contains(focusedPlatform) {
            
           platformId = row.index
            
            firstSelectionBarButton.title = row[7] as! String
            secondSelectionBarButton.title = row[10] as! String
            thirdSelectionBarButton.title = row[13] as! String
            forthSelectionBarButton.title = row[16] as! String
            fifthSelectionBarButton.title = row[19] as! String
            sixthSelectionBarButton.title = row[22] as! String
          
            objectSizeUpdater()
        }
    }
}


func buttonActionGetter(_ buttonActionLine: Int, platformId: Int) -> String {
    
    
   let buttonAction = result!.rows[platformId][buttonActionLine] as! String
    return buttonAction
    
    
  
}





