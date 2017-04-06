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
    func replace(_ string: String, replacment: String) -> String {
        return self.replacingOccurrences(of: string, with: replacment, options: NSString.CompareOptions.literal, range: nil)
    }
    func removeWhiteSpaces() -> String {
        return self.replace(" ", replacment: "")
    }
}
extension Array where Element: Equatable {
    //Simple function to remove object based on name
    mutating func removeObject(_ object : Iterator.Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
    func randomObject() -> Iterator.Element? {
        if self.count > 0 {
            let randomInt: Int = Int(arc4random_uniform(UInt32(self.count)))
            return self[randomInt]
        } else {
            return nil
        }
    }
}

func GSDSeconds(seconds delay: Double) -> DispatchTime {
    return DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
}
func runAfterDelay(_ delay: TimeInterval, block: @escaping ()->()) {
    let time = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: time, execute: block)
}
func makeSimpleAlertView(_ title: String, message: String, target: UIViewController) {
    let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    ac.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.cancel, handler: nil))
    target.present(ac, animated: true, completion: nil)
}
