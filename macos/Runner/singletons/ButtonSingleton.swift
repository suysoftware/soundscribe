//
//  ButtonSingleton.swift
//  Runner
//
//  Created by ILION INC on 16.03.2023.
//

import Foundation
import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI

class ButtonSingleton {
    static let instance = ButtonSingleton()
    var data: Bool = false;

    private init() { }

    func SetData(value: Bool){
        data = value
    }

    func GetData() -> Bool{
        return data
    }
}
