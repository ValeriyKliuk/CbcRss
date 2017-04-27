//
//  Helper.swift
//  CbcRss
//
//  Created by Valeriy Kliuk on 2017-04-26.
//  Copyright © 2017 Valeriy Kliuk. All rights reserved.
//

import Foundation

/// Helper class
class Helper {
    // reachable from other classes
    static let shared: Helper = Helper()
    
    // not reachable from other classes
    private init() {}
    
    /// CBC request link
    let requestLink: String = "http://www.cbc.ca/cmlink/rss-topstories"
}
