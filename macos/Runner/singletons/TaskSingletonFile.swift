//
//  TaskSingletonFile.swift
//  Runner
//
//  Created by ILION INC on 10.03.2023.
//

import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI

class FirstTaskSingleton {
    static let instance = FirstTaskSingleton()
    var data: Bool = false;

    private init() { }

    func SetData(value: Bool){
        data = value
    }

    func GetData() -> Bool{
        return data
    }
}
