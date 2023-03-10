//
//  ChannelSingletonFile.swift
//  Runner
//
//  Created by ILION INC on 10.03.2023.
//

import Foundation
import Cocoa
import FlutterMacOS
import AppKit
import SwiftUI

class ChannelSingleton {
static let shared = ChannelSingleton()
var channel: FlutterMethodChannel = FlutterMethodChannel()
}
