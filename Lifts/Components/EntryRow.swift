//
//  EntryRow.swift
//  EntryRow
//
//  Created by Benjamin Ashman on 8/23/21.
//

import SwiftUI

struct EntryRow: View {
    let entry: Entry
    
    @State var viewState = CGSize.zero
    @State var isSwiped = false
    
    @State var selectedId = 0
    
    var body: some View {
        VStack {
            NavigationLink(destination: EntryDetailView(entry: entry),
                label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(entry.exercise?.name ?? "No exercise name")
                                .font(.system(size: 20.0, weight: .bold, design: .rounded))
                                .padding(.bottom, 2)
                                .foregroundColor(.accentColor)
                            Text(entry.setsDescription)
                                .font(.system(size: 14.0, weight: .medium, design: .default))
                                .foregroundColor(Color(hex: 0xEBEBF5))
                            if !entry.notesContent.isEmpty {
                                Text(entry.notesContent)
                                    .font(.system(size: 12.0, weight: .regular, design: .default))
                                    .foregroundColor(Color(hex: 0xEBEBF5, alpha: 0.6))
                                    .padding(.top, -3)
                            }
                        }
                        
                        // Fill full with of container
                        Spacer()
                    }
                }
            )
        }
        .padding(20)
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.5 : 1)
            .background(Color.blue)
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
