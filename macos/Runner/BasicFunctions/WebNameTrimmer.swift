//
//  WebNameTrimmer.swift
//  Runner
//
//  Created by ILION INC on 23.03.2023.
//

import Foundation
func webNameTrimmer(_ source: String) -> String {
    
    var platformName = source
    
    

    

    
    if(platformName.starts(with:"https://" )){
       platformName = source.replacingOccurrences(of:"https://", with: "")
        
    }
    else if (platformName.starts(with:"http://" )){
        
        platformName = source.replacingOccurrences(of:"http://", with: "")
    }

    
    if(platformName.starts(with: "www.")){
        
   platformName =  platformName.replacingOccurrences(of:"www.", with: "")
        
    }
    
    
     if (platformName.contains(".google")){
         
         if(platformName.contains(".")){
             let platformSelfIndex = platformName.firstIndex(of: ".") ?? platformName.endIndex
             let platformSelfName = String(platformName[..<platformSelfIndex])
        
             
             platformName = platformSelfName + ".google"
             
         }
   
    }
    else {
        
        let index = platformName.firstIndex(of: ".") ?? platformName.endIndex
        platformName = String(platformName[..<index])
    }
    
    
    
    
    
    
    
    return platformName.lowercased()
    
    
    
}
