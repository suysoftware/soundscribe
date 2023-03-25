//
//  RunTitleAppleScript.swift
//  Runner
//
//  Created by ILION INC on 25.03.2023.
//

import Foundation
func runAppTitleAppleScript(_ source: String) -> String? {
    var error: NSDictionary?
    if let scriptObject = NSAppleScript(source: source) {
        let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(&error)
        if error != nil {
            print("AppleScript execution failed: \(error!)")
            return nil
        } else {
            return output.stringValue
        }
    } else {
        print("AppleScript compilation failed")
        return nil
    }
}
