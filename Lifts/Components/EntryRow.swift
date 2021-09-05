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
                        .font(.system(size: 20.0, weight: .bold, design: .rounded))
                        .padding(.bottom, -4)
                    Text(entry.setsDescription)
                        .font(.system(size: 14.0, weight: .bold, design: .default))
                        .foregroundColor(.secondary)
                    if !entry.notesContent.isEmpty {
                        Text(entry.notesContent)
                            .font(.system(size: 12.0, weight: .regular, design: .default))
                            .foregroundColor(.secondary)
                            .padding(.top, -6)
                    }
                }
                .padding(.top, 8)
                .padding(.bottom, 8)
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
