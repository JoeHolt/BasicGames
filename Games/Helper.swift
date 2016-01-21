//
//  Helper.swift
//  Games
//
//  Created by Joe Holt on 1/20/16.
//  Copyright © 2016 Joe Holt Apps. All rights reserved.
//

import Foundation
func secondsToDispatchTime(timeSeconds delay: Double) -> dispatch_time_t {
    return dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
}
