//
//  PlatformObjectGetter.swift
//  Runner
//
//  Created by ILION INC on 25.03.2023.
//


import Foundation
import AppKit



var firstSelectionBarButton = FirstSelectionButton(title: "Dc1", frame: NSRect(x: 0, y: 0, width: 100, height: 25))
var secondSelectionBarButton = SecondSelectionButton(title: "Dc2", frame: NSRect(x: 100, y: 0, width: 100, height: 25))
var thirdSelectionBarButton = ThirdSelectionButton(title: "Dc3", frame: NSRect(x: 200, y: 0, width: 100, height: 25))
var forthSelectionBarButton = ForthSelectionButton(title: "Dc4", frame: NSRect(x: 300, y: 0, width: 100, height: 25))
var fifthSelectionBarButton = FifthSelectionButton(title: "Dc5", frame: NSRect(x: 400, y: 0, width: 100, height: 25))
var sixthSelectionBarButton = SixthSelectionButton(title: "Talk", frame: NSRect(x: 500, y: 0, width: 50, height: 25))

var toolTipText = ToolTipText(title:"sak", frame: NSRect(x: 0, y: 0, width: 150, height: 300))

let chromium_variants = ["Google Chrome", "Chromium", "Opera", "Vivaldi", "Brave Browser", "Microsoft Edge","Safari","Tor Browser","Yandex"]

var platformId = 0


var animateFirstToolTip = false
var animateSecondToolTip = false
var animateThirdToolTip = false
var animateForthToolTip = false
var animateFifthToolTip = false
var animateSixthToolTip = false
