//
//  EntryRow.swift
//  EntryRow
//
//  Created by Benjamin Ashman on 8/23/21.
//

import SwiftUI

struct EntryRow: View {
    let entry: Entry
    
    var body: some View {
        NavigationLink(destination: EntryDetailView(entry: entry),
            label: {
                VStack(alignment: .leading) {
                    Text(entry.exercise?.name ?? "No exercise name")
                        .font(.title3)
                    Text(entry.setsDescription)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    if !entry.notesContent.isEmpty {
                        Text(entry.notesContent)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
        )
    }
}

//struct EntryRow_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryRow()
//    }
//}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
