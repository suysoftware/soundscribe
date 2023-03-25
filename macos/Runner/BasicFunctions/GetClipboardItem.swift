//
//  GetClipboardItem.swift
//  Runner
//
//  Created by ILION INC on 25.03.2023.
//

import Foundation
import AppKit

func getClipboardItem() -> String? {
    guard let string = NSPasteboard.general.string(forType: .string) else {
        // The clipboard is empty or does not contain a string
        return nil
    }
    // Found a string item on the clipboard
    return string
}
