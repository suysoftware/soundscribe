//
//  FocusedPanelGetter.swift
//  Runner
//
//  Created by ILION INC on 16.03.2023.
//

import Foundation
import AppKit


let panelRect = NSRect(x: 0, y: 0, width: 200, height: 25)
let styleMask = NSWindow.StyleMask(arrayLiteral:[.borderless, .nonactivatingPanel,] )


func focusedPanelGetter(_ source: String) -> NSPanel {
    
    switch source {
        
        
    case "com.apple.dt.Xcode":
        return XcodePanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "com.hnc.Discord":
        return DiscordPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "com.spotify.client":
        return SpotifyPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "com.microsoft.VSCode":
        return VscodePanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "com.apple.Notes":
        return AppleNotesPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "com.apple.AppStore":
       return AppleAppstorePanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "com.figma.Desktop":
        return FigmaPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "com.binance.BinanceDesktop":
       return BinancePanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "com.tradingview.tradingviewapp.desktop":
      return TrandingviewPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "desktop.WhatsAp":
      return WhatsappPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "com.microsoft.Word":
        return WordPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "com.microsoft.Powerpoint":
        return PowerpointPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "com.microsoft.Excel":
        return ExcelPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "com.google.android.studio":
        return AndroidstudioPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "www.youtube.com":
        return YoutubePanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "github.com":
        return GithubPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "mail.google.com":
        return GmailPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "twitter.com":
        return TwitterPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "www.facebook.com":
        return FacebookPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "tr.wikipedia.org":
        return WikipediaPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "fr.wikipedia.org":
        return WikipediaPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "en.wikipedia.org":
        return WikipediaPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "de.wikipedia.org":
        return WikipediaPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "hi.wikipedia.org":
        return WikipediaPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "www.wikipedia.org":
        return WikipediaPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "mail.yahoo.com":
        return YahooPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "www.amazon.com":
        return AmazonPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "outlook.live.com":
        return OutlookPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "www.linkedin.com":
        return LinkedinPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "www.reddit.com":
        return RedditPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "www.netflix.com":
        return NetflixPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "www.twitch.tv":
        return TwitchPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "www.ebay.com":
        return EbayPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "www.tiktok.com":
        return TiktokPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "web.whatsapp.com":
        return WhatsappPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    case "ImagePreview":
        return ImagePreviewPanel(contentRect: NSRect(x: 0, y: 0, width: 1000, height: 1000), styleMask: styleMask, backing: .buffered, defer: false)
    case "default":
       return DefaultPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    default:
        return DefaultPanel(contentRect: panelRect, styleMask: styleMask, backing: .buffered, defer: false)
    }
}






/*import Foundation
 import AppKit



 func focusedPanelGetter(_ source: String, nsRect: NSRect) -> NSPanel {
     
     switch source {
         
         
     case "com.apple.dt.Xcode":
         return XcodePanel(contentRect: nsRect, styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
     case "com.hnc.Discord":
         return DiscordPanel(contentRect: nsRect, styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
     case "com.spotify.client":
         return SelectionBarPanel(contentRect: nsRect, styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
     default:
         return SelectionBarPanel(contentRect: nsRect, styleMask: [.borderless, .nonactivatingPanel,], backing: .buffered, defer: false)
     }
 }
*/
