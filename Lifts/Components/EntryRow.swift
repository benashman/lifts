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
                    Text("Entry at \(entry.timestamp!, formatter: itemFormatter)")
                        .font(.caption)
                    Text(entry.setsDescription)
                        .font(.caption)
                    Text(entry.notesContent)
                        .font(.caption)
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
