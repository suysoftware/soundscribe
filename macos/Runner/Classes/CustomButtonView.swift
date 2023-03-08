//
//  CustomButtonView.swift
//  Runner
//
//  Created by ILION INC on 8.03.2023.
//

import Foundation
import FlutterMacOS
import AppKit


class CustomButtonView: NSView {
    
    override func accessibilityRole() -> NSAccessibility.Role? {
        return NSAccessibility.Role.button
    }

    override func isAccessibilityElement() -> Bool {
        return true
    }
}
