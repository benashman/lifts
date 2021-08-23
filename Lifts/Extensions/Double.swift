//
//  Double.swift
//  Double
//
//  Created by Benjamin Ashman on 8/23/21.
//

import Foundation

extension Double {
    
    // Strip trailing zeros but retain non-zero decimal values
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
