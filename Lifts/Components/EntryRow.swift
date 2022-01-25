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
    
    var body: some View {
        ZStack {
            Rectangle()
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(Color(UIColor.red))
                .background(Color(UIColor.red))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            HStack {
                Spacer()
                Button(action: {
                    DataHelper.deleteEntry(entry)
                    print("Deleting entry \(entry.exerciseName)")
                }, label: {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                        .foregroundColor(Color(UIColor.white))
                })
                    .padding(.trailing, 32)
            }
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
            .offset(x: min(0, viewState.width), y: .zero)
            .highPriorityGesture(
                DragGesture()
                    .onChanged(onChanged(value:))
                    .onEnded(onEnded(value:))
            )
        }
    }
    
    func onChanged(value: DragGesture.Value) {
        viewState = value.translation
        print(viewState.width)
    }
    
    func onEnded(value: DragGesture.Value) {
        withAnimation(.spring()) {
            if viewState.width < -50 {
                viewState = CGSize(width: -100, height: .zero)
            } else {
                viewState = .zero
            }
        }
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
