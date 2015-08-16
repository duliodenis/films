//
//  StringExtension.swift
//  Films
//
//  Created by Dulio Denis on 8/16/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

import Foundation

extension String {
    
    // Our own String subscript syntax
    subscript(r: Range<Int>) -> String? {
        // if the string is not empty
        if !self.isEmpty {
            // Our start and end positions
            var start   = advance(startIndex, r.startIndex)
            var end     = advance(startIndex, r.endIndex)
            
            // return the substring with our range
            return substringWithRange(Range(start: start, end: end))
        }
        // otherwise return nil on an empty string
        return nil
    }
    
    
    // find the index of a letter
    func findIndexOf(letter: String) -> Int? {
        // create our working string and an array
        var tempString = self
        var selfArray : [String] = []
        var index = 0
        
        // copy every characters of the string into an array
        for character in tempString {
            selfArray.append(String(character))
        }
        
        // if we find what we were looking for then return where
        for character in 0..<selfArray.count {
            if letter == selfArray[index] {
                return index
            }
            // otherwise go to the next one
            ++index
        }
        // if we find no letter matching return nil
        return nil
    }
    
    
}