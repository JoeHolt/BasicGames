//
//  Helper.swift
//  Games
//
//  Created by Joe Holt on 1/20/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func replace(string: String, replacment: String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacment, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    func removeWhiteSpaces() -> String {
        return self.replace(" ", replacment: "")
    }
}
extension Array where Element: Equatable {
    //Simple function to remove object based on name
    mutating func removeObject(object : Generator.Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
    func randomObject() -> Generator.Element? {
        if self.count > 0 {
            let randomInt: Int = Int(arc4random_uniform(UInt32(self.count)))
            return self[randomInt]
        } else {
            return nil
        }
    }
}

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
