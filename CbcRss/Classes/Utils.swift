//
//  Utils.swift
//  CbcRss
//
//  Created by Valeriy Kliuk on 2017-04-26.
//  Copyright © 2017 Valeriy Kliuk. All rights reserved.
//

import Foundation

/// Utils class to have usefull methods/func
class Utils {
    
    /// lazy ;) image URL string parsing
    class func getImageURL(string description: String, start from: String, end to: String) -> String {
        /// remove whitespaces and new lines
        var result = description.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        /// find index of the end '.jpg'
        var index = result.range(of: to, options: .backwards)?.upperBound
        /// cut anything to index
        result = result.substring(to: index!)
        /// find index of the start "<img src='"
        index = result.range(of: from, options: .backwards)?.upperBound
        /// cut anything from index
        result = result.substring(from: index!)
        /// return the result
        return result
    }

    
}
