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
        
        return   """
        tell application "Firefox"
           set currentTab to current tab of window 1
           set currentUrl to URL of currentTab
           return currentUrl
        end tell
        """
    case "Google Chrome":
        return  """
                    tell application "Google Chrome"
                     set currentTab to current tab of window 1
                     set currentUrl to URL of currentTab
                     return currentUrl
                    end tell
                    
                    """
    case "Chromium":
        return    """
                     tell application "Chromium"
                        set currentTab to current tab of window 1
                        set currentUrl to URL of currentTab
                        return currentUrl
                    end tell
                    """
    case "Opera":
        return  """
                     tell application "Opera"
                            set currentTab to current tab of window 1
                            set currentUrl to URL of currentTab
                            return currentUrl
                        end tell
                    """
    case "Vivaldi":
        return  """
                     tell application "Vivaldi"
                        set currentTab to current tab of window 1
                        set currentUrl to URL of currentTab
                        return currentUrl
                    end tell
                    """
    case "Brave Browser":
        return """
                      tell application "Brave Browser"
                        set currentTab to current tab of window 1
                        set currentUrl to URL of currentTab
                        return currentUrl
                    end tell
                    """
    case "Microsoft Edge":
        return """
                    tell application "Microsoft Edge"
                          set currentTab to current tab of window 1
                          set currentUrl to URL of currentTab
                          return currentUrl
                      end tell
                    """
    case "Tor Browser":
        return """
                     tell application "Tor Browser"
                          set currentTab to current tab of window 1
                          set currentUrl to URL of currentTab
                          return currentUrl
                      end tell
                    """
    case "Yandex":
        return  """
                    tell application "Yandex"
                         set currentTab to current tab of window 1
                         set currentUrl to URL of currentTab
                         return currentUrl
                     end tell
                    """
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
