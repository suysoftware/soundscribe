//
//  CopyToClipboard.swift
//  Runner
//
//  Created by ILION INC on 25.03.2023.
//

import Foundation
import AppKit
func copyToClipboard(_ string: String) {
    let pasteboard = NSPasteboard.general
    pasteboard.clearContents()
    pasteboard.setString(string, forType: .string)
}
