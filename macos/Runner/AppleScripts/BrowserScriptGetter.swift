//
//  BrowserScriptGetter.swift
//  Runner
//
//  Created by ILION INC on 16.03.2023.
//

import Foundation


func scriptTextGetterForBrowsers(_ source: String) -> String {
    
    switch source {
        
        
    case "Safari":
        return """
tell application "Safari"
set currentTab to current tab of window 1
set currentUrl to URL of currentTab
return currentUrl
end tell
"""
    case "Firefox":
        return "tell app \"Firefox\" to get the url of the active tab of window 1"
    case "Google Chrome":
        return "tell app \"Google Chrome\" to get the url of the active tab of window 1"
    case "Chromium":
        return "tell app \"Chromium\" to get the url of the active tab of window 1"
    case "Opera":
        return "tell app \"Opera\" to get the url of the active tab of window 1"
    case "Vivaldi":
        return "tell app \"Vivaldi\" to get the url of the active tab of window 1"
    case "Brave Browser":
        return "tell app \"Brave Browser\" to get the url of the active tab of window 1"
    case "Microsoft Edge":
        return "tell app \"Microsoft Edge\" to get the url of the active tab of window 1"
    case "Tor Browser":
        return "tell app \"Tor Browser\" to get the url of the active tab of window 1"
    case "Yandex":
        return "tell app \"Yandex\" to get the url of the active tab of window 1"
    default:
        return """
                    tell application "Safari"
                        set currentTab to current tab of window 1
                        set currentUrl to URL of currentTab
                        return currentUrl
                    end tell
                    """
    }
}
