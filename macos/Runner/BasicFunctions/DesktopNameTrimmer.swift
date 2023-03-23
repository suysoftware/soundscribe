//
//  DesktopNameTrimmer.swift
//  Runner
//
//  Created by ILION INC on 23.03.2023.
//

import Foundation

func desktopNameTrimmer(source: String, isApple: Bool) -> String {
    
    var platformName = source
    
   
    
    print(source)
    platformName =  platformName.replacingOccurrences(of:"com.apple.", with: "")
    
    
    if(platformName.starts(with: "dt.")){
        
        platformName =  platformName.replacingOccurrences(of:"dt.", with: "")
    }
    
    
    
    
    
    
    
    return platformName.lowercased()
    
    
    
}
