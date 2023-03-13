//
//  SegmentedViewController.swift
//  Runner
//
//  Created by ILION INC on 13.03.2023.
//

import Foundation
import SwiftUI
 
class SegmentedController: NSViewController {
 
    @IBOutlet weak var uiViewOutlet: NSView!
    
    @IBOutlet weak var segmentControlOutlet: NSSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiViewOutlet.layer!.backgroundColor = CGColor.white
        uiViewOutlet.frame = NSRect(x: 0, y: 0, width: 500, height: 405)
        segmentControlOutlet.layer!.backgroundColor = CGColor.white
        
    }
   
    @IBAction func segmentControllClick(_ sender: Any) {
        switch segmentControlOutlet.selectedSegment{
        case 0:
            uiViewOutlet.layer!.backgroundColor = CGColor.white
            segmentControlOutlet.layer!.backgroundColor =  CGColor.white
        case 1 :
            uiViewOutlet.layer!.backgroundColor = CGColor.black
            segmentControlOutlet.layer!.backgroundColor = CGColor.black
        case 2:
            uiViewOutlet.layer!.backgroundColor = CGColor.clear
            segmentControlOutlet.layer!.backgroundColor = CGColor.clear
        default:
            break
        }
        
        
    }
    
}







struct SegmentedContent: View {

     



    // Never comes her
    
    var body: some View
        
        
     {   HStack(alignment: .center) {
           
           
           Button("Add Individual Task", action: {
               
           })
           Button("Send Task", action: {
               
           })
           Button("Send Task", action: {
               
           })
       }}

        

    }
   
      
      


struct SegmentedContent_Previews: PreviewProvider {

    static var previews: some View {
        
        SegmentedContent()
    }
}
