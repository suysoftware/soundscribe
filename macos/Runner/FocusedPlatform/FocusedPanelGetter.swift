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
var result = try? DataFrame(contentsOfCSVFile: url)

var platformData: PlatformModel?


func getDataFromSheet() {

    
    if let url = URL(string: "https://us-central1-training-database-8946f.cloudfunctions.net/thinkBuddyCsv") {
        do {
            let csvData = try Data(contentsOf: url)
          //  let csvString = String(data: csvData, encoding: .utf8)
           // let csvRows = csvString?.components(separatedBy: "\n")
            //let csvColumns = csvRows?.map { $0.components(separatedBy: ",") }
            
            
            //result = try? DataFrame(jsonData: csvData)
        //    let platformModel = try? JSONDecoder().decode(PlatformModel.self, from: csvData)
            
   
            platformData =  try? JSONDecoder().decode(PlatformModel.self, from: csvData)
           
        
            // Here, you can use the csvColumns array to create a DataFrame
        } catch {
            print("Error reading CSV file: \(error.localizedDescription)")
        }
    } else {
        print("Invalid URL")
    }
    
    
    
   /* guard let url = URL(string: urlString) else { print("error"); return }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
           if let content = String(data: data, encoding: .utf8) {
                let parsedCSV: [String] = content.components(separatedBy: "\n")
                // all data
                print(parsedCSV, "\n")
                // first line
                print(parsedCSV.map{ $0.components(separatedBy: ",")}[0], "\n")
                // second line
             //   print(parsedCSV.map{ $0.components(separatedBy: ",")}[1], "\n")

                
            }
        }
      
    }.resume()*/
}


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
var sixthButtonWidth = 40
var sixthButtonX = firstSelectionBarButton.title.count*widthValue + secondSelectionBarButton.title.count*widthValue + thirdSelectionBarButton.title.count*widthValue + forthSelectionBarButton.title.count*widthValue + fifthSelectionBarButton.title.count*widthValue
var panelRect = NSRect(x: 0, y: 0, width: (firstSelectionBarButton.title.count*widthValue+secondSelectionBarButton.title.count*widthValue+thirdSelectionBarButton.title.count*widthValue+forthSelectionBarButton.title.count*widthValue+fifthSelectionBarButton.title.count*widthValue+sixthSelectionBarButton.title.count*widthValue), height: 25)

var toolTipRect = NSRect(x: 0, y: 0, width:0, height: 150)

var styleMask = NSWindow.StyleMask(arrayLiteral:[.borderless, .nonactivatingPanel,] )





func focusedPanelExcel(_ source: String) {
    
    let focusedPlatform = ">"+source+"<"
    
    firstSelectionBarButton.title = result!.rows[0][7] as! String
    secondSelectionBarButton.title = result!.rows[0][10] as! String
    thirdSelectionBarButton.title = result!.rows[0][13] as! String
    forthSelectionBarButton.title = result!.rows[0][16] as! String
    fifthSelectionBarButton.title = result!.rows[0][19] as! String
    sixthSelectionBarButton.title = "  "
   // sixthSelectionBarButton.title = result!.rows[0][22] as! String
    objectSizeUpdater()
    
    do {
        
        for element in platformData! {
            
            let platformId = element.platformID
            
         
            let platformName = (platformId ).lowercased()

            if platformName.contains(focusedPlatform) {
                
                
                platformNo = element.id
                
                firstSelectionBarButton.title = element.firstButton
                secondSelectionBarButton.title = element.secondButton
                thirdSelectionBarButton.title = element.thirdButton
                forthSelectionBarButton.title = element.forthButton
                fifthSelectionBarButton.title = element.fifthButton
                sixthSelectionBarButton.title = "  "
             //   sixthSelectionBarButton.title = row[22] as! String
              
                objectSizeUpdater()
            }
        }
     
        
   
    
    } catch {
        
    
        result!.rows.forEach { row in
            
     
           
            let leftString = row[3]!
            
         
            let platformName = (leftString as! String).lowercased()

            if platformName.contains(focusedPlatform) {
                
                
               platformNo = row.index
                
                firstSelectionBarButton.title = row[7] as! String
                secondSelectionBarButton.title = row[10] as! String
                thirdSelectionBarButton.title = row[13] as! String
                forthSelectionBarButton.title = row[16] as! String
                fifthSelectionBarButton.title = row[19] as! String
                sixthSelectionBarButton.title = "  "
             //   sixthSelectionBarButton.title = row[22] as! String
              
                objectSizeUpdater()
            }
        }
        
        
        print("Unexpected error: \(error).")
    }
    
    
    
    
    
    if(platformData == nil){
        
        
        
        
    }
    
    
    
    
    
    

    

}


func buttonActionGetter(_ buttonActionLine: Int, platformNo: Int) -> String {
    
    
    
    do {
        let platformElement = platformData![platformNo]
        
        switch buttonActionLine {
            
            
        case 1:
            return platformElement.firstButtonAction
        case 2:
            return platformElement.secondButtonAction
        case 3:
            return platformElement.thirdButtonAction
        case 4:
            return platformElement.forthButtonAction
        case 5:
            return platformElement.fifthButtonAction
        case 6:
            return platformElement.sixthButtonAction
        default:
            return ""
        }
        
        
        
   
    }
    
    catch {
        
        print("action catch calisti")
        
        let buttonAction = result!.rows[platformNo][buttonActionLine] as! String
         return buttonAction
    }
    

    
    
  
}





