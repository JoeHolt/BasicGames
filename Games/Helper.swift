//
//  Helper.swift
//  Games
//
//  Created by Joe Holt on 1/20/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import Foundation
import UIKit

func GSDSeconds(seconds delay: Double) -> dispatch_time_t {
    return dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
}
func runAfterDelay(delay: NSTimeInterval, block: dispatch_block_t) {
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    dispatch_after(time, dispatch_get_main_queue(), block)
}
func makeSimpleAlertView(title: String, message: String, target: UIViewController) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    ac.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Cancel, handler: nil))
    target.presentViewController(ac, animated: true, completion: nil)
}
