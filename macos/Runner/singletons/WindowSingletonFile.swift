//
//  WindowSingletonFile.swift
//  Runner
//
//  Created by ILION INC on 10.03.2023.
//

import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI


class WindowSingleton {
static let shared = WindowSingleton()
var window: FlutterViewController = FlutterViewController()
}
