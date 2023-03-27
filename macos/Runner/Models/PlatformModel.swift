//
//  PlatformModel.swift
//  Runner
//
//  Created by ILION INC on 27.03.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//

//   let platformModel = try? JSONDecoder().decode(PlatformModel.self, from: jsonData)
import Foundation

// MARK: - PlatformModelElement
struct PlatformModelElement: Codable {
    let id: Int
    let platform: String
    let type: String
    let platformID: String
    let websiteURL: String
    let category, tags, firstButton, firstButtonTooltip: String
    let firstButtonAction, secondButton: String
    let secondButtonTooltip: String
    let secondButtonAction, thirdButton: String
    let thirdButtonTooltip: String
    let thirdButtonAction, forthButton, forthButtonAction, forthButtonTooltip: String
    let fifthButton: String
    let fifthButtonTooltip: String
    let fifthButtonAction: String
    let sixthButton: String
    let sixthButtonTooltip: String
    let sixthButtonAction: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case platform = "Platform"
        case type = "Type"
        case platformID = "PlatformId"
        case websiteURL = "WebsiteUrl"
        case category = "Category"
        case tags = "Tags"
        case firstButton = "FirstButton"
        case firstButtonTooltip = "FirstButtonTooltip"
        case firstButtonAction = "FirstButtonAction"
        case secondButton = "SecondButton"
        case secondButtonTooltip = "SecondButtonTooltip"
        case secondButtonAction = "SecondButtonAction"
        case thirdButton = "ThirdButton"
        case thirdButtonTooltip = "ThirdButtonTooltip"
        case thirdButtonAction = "ThirdButtonAction"
        case forthButton = "ForthButton"
        case forthButtonAction = "ForthButtonAction"
        case forthButtonTooltip = "ForthButtonTooltip"
        case fifthButton = "FifthButton"
        case fifthButtonTooltip = "FifthButtonTooltip"
        case fifthButtonAction = "FifthButtonAction"
        case sixthButton = "SixthButton"
        case sixthButtonTooltip = "SixthButtonTooltip"
        case sixthButtonAction = "SixthButtonAction"
    }
}




typealias PlatformModel = [PlatformModelElement]
