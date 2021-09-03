//
//  Entry.swift
//  Entry
//
//  Created by Benjamin Ashman on 8/23/21.
//

import Foundation

extension Entry {
    
    var setsDescription: String {
        var setDescriptions: [String] = []
        
        if let sets = self.sets {
            for s in sets {
                let entrySet = s as! Set
                let description = "\(entrySet.weight.cleanValue) x \(entrySet.reps)"
                setDescriptions.append(description)
            }
        }
        
        return setDescriptions.joined(separator: ", ")
    }
    
    var notesContent: String {
        return notes ?? "No notes"
    }
    
    var exerciseName: String {
        return exercise?.name ?? "Unknown Exercise"
    }
}
