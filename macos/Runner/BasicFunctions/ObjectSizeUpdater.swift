//
//  ObjectSizeUpdater.swift
//  Runner
//
//  Created by ILION INC on 23.03.2023.
//

import Foundation

func objectSizeUpdater() {

 
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

    
    
    firstSelectionBarButton.frame = NSRect(x: firstButtonX, y: 0, width: firstButtonWidth, height:25)
    secondSelectionBarButton.frame = NSRect(x: secondButtonX, y: 0, width: secondButtonWidth, height:25)
    thirdSelectionBarButton.frame = NSRect(x: thirdButtonX, y: 0, width: thirdButtonWidth, height:25)
    forthSelectionBarButton.frame = NSRect(x: forthButtonX, y: 0, width: forthButtonWidth, height:25)
    fifthSelectionBarButton.frame = NSRect(x: fifthButtonX, y: 0, width: fifthButtonWidth, height:25)
    sixthSelectionBarButton.frame = NSRect(x: sixthButtonX, y: 0, width: sixthButtonWidth, height:25)
}
