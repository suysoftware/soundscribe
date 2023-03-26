//
//  ToolTipAnimateBoolUpdater.swift
//  Runner
//
//  Created by ILION INC on 25.03.2023.
//

import Foundation



func updateAllToolTipAnimate(whichButton: String, whichOrder: Bool){


    
    
    switch whichButton {
        
        
    case "First":
        if(whichOrder == true){
            toolTipString = result?.rows[platformId][8] as! String
       
           animateFirstToolTip = true
            animateSecondToolTip = false
            animateThirdToolTip = false
            animateForthToolTip = false
            animateFifthToolTip = false
            animateSixthToolTip = false
        }
        else {
            
            animateFirstToolTip = false
        }
        

     
    case "Second":
        
        if(whichOrder == true){
            toolTipString = result?.rows[platformId][11] as! String
         
            animateSecondToolTip = true
            animateFirstToolTip = false
            animateThirdToolTip = false
            animateForthToolTip = false
            animateFifthToolTip = false
            animateSixthToolTip = false
        }
        else {
            
            animateSecondToolTip = false
        }
    
      
    case "Third":
        if(whichOrder == true){
            toolTipString = result?.rows[platformId][14] as! String

            animateThirdToolTip = true
            animateFirstToolTip = false
            animateSecondToolTip = false
            animateForthToolTip = false
            animateFifthToolTip = false
            animateSixthToolTip = false
        }
        else {
            
            animateThirdToolTip = false
        }
      

      
    case "Forth":
        if(whichOrder == true){
            toolTipString = result?.rows[platformId][17] as! String
           
            animateForthToolTip = true
            animateThirdToolTip = false
            animateFirstToolTip = false
            animateSecondToolTip = false
            animateFifthToolTip = false
            animateSixthToolTip = false
        }
        else {
            
            animateForthToolTip = false
        }
   
        
       
    case "Fifth":
        if(whichOrder == true){
            toolTipString = result?.rows[platformId][20] as! String
  
            animateFifthToolTip = true
            animateFirstToolTip = false
            animateSecondToolTip = false
            animateThirdToolTip = false
            animateForthToolTip = false
            animateSixthToolTip = false
        }
        else {
            
            animateFifthToolTip = false
        }
     
  
   
    case "Sixth":
        
        if(whichOrder == true){
            toolTipString = result?.rows[platformId][23] as! String
      
            animateSixthToolTip = true
            animateFirstToolTip = false
            animateSecondToolTip = false
            animateThirdToolTip = false
            animateForthToolTip = false
            animateFifthToolTip = false
    
        }
        else {
            
            animateSixthToolTip = false
        }
   
    case "ALL":
        if(whichOrder == true){
            animateFirstToolTip = true
            animateSecondToolTip = true
            animateThirdToolTip = true
            animateForthToolTip = true
            animateFifthToolTip = true
            animateSixthToolTip = true
        }
        else {
            
            animateFirstToolTip = false
            animateSecondToolTip = false
            animateThirdToolTip = false
            animateForthToolTip = false
            animateFifthToolTip = false
            animateSixthToolTip = false
        }
        
        
    
     
    
    default:
        
        animateFirstToolTip = false
        animateSecondToolTip = false
        animateThirdToolTip = false
        animateForthToolTip = false
        animateFifthToolTip = false
        animateSixthToolTip = false
    
    }
    
}
