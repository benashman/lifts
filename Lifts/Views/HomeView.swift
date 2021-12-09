//
//  HomeView.swift
//  Lifts
//
//  Created by Benjamin Ashman on 8/23/21.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Entry.timestamp, ascending: true)],
        animation: .default)
    private var entries: FetchedResults<Entry>
    
    @State private var searchText = ""
    
    @State var showingAddEntrySheet = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(groupedEntries(entries).indices, id: \.self) { section in
                            Section(header: DateSectionHeader(date: groupedEntries(entries)[section][0].timestamp!)) {
                                ForEach(groupedEntries(entries)[section], id: \.self) { entry in
                                    EntryRow(entry: entry)
//                                        .onDelete {
//                                            print("delete")
//                                        }
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 16.0, bottom: 0, trailing: 16.0))
                }
//                List {
//                    ForEach(groupedEntries(entries).indices, id: \.self) { section in
//                        Section(header: DateSectionHeader(date:
//                            groupedEntries(entries)[section][0].timestamp!)) {
//                            ForEach(groupedEntries(entries)[section], id: \.self) { entry in
//                                EntryRow(entry: entry)
//                                    .buttonStyle(CustomButtonStyle())
//                            }
//                            .onDelete { offsets in
//                                deleteItems(offsets: offsets, section: section)
//                            }
//                        }
//                    }
//                }
//                .buttonStyle(CustomButtonStyle())
//                .navigationBarTitleDisplayMode(.inline)
//                .listStyle(PlainListStyle())
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button(action: {
//                            showingAddEntrySheet.toggle()
//                        }) {
//                            Text("Add Entry")
//                        }
//                    }
//                }
                .sheet(isPresented: $showingAddEntrySheet) {
                    ExercisesView(showingAddEntrySheet: $showingAddEntrySheet)
                        .environment(\.managedObjectContext, viewContext)
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .navigationBarTitle("", displayMode: .inline)
                
                Button(action: {
                    showingAddEntrySheet.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .heavy, design: .rounded))
                })
                .buttonStyle(AddButtonStyle())
                .padding(.trailing, 32)
            }
        }
    }
    
    private func groupedEntries(_ result: FetchedResults<Entry>) -> [[Entry]] {
        return Dictionary(grouping: result) { (element: Entry) in
            dateFormatter.string(from: element.timestamp!)
        }.values.sorted() { $0[0].timestamp! > $1[0].timestamp! }
    }
    
    private func addItem() {
        withAnimation {
            let newEntry = Entry(context: viewContext)
            newEntry.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteEntry(_ entry: Entry) {
        withAnimation {
            print("deleting entry: ")
            print(entry)
            
            viewContext.delete(entry)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet, section: Int) {
        withAnimation {
            offsets.map { groupedEntries(entries)[section][$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 64, height: 64)
            .foregroundColor(Color.black)
            .background(Color.accentColor)
//            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .cornerRadius(32.0)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

// TODO: Use this as inspo for the delete behavior we actually want
struct Delete: ViewModifier {
    
    let action: () -> Void
    
    @State var offset: CGSize = .zero
    @State var initialOffset: CGSize = .zero
    @State var contentWidth: CGFloat = 0.0
    @State var willDeleteIfReleased = false
   
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    ZStack {
                        Rectangle()
                            .foregroundColor(.red)
                        Image(systemName: "trash")
                            .foregroundColor(.white)
                            .font(.title2.bold())
                            .layoutPriority(-1)
                    }.frame(width: -offset.width)
                    .offset(x: geometry.size.width)
                    .onAppear {
                        contentWidth = geometry.size.width
                    }
                    .gesture(
                        TapGesture()
                            .onEnded {
                                delete()
                            }
                    )
                }
            )
            .offset(x: offset.width, y: 0)
            .gesture (
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width + initialOffset.width <= 0 {
                            self.offset.width = gesture.translation.width + initialOffset.width
                        }
                        if self.offset.width < -deletionDistance && !willDeleteIfReleased {
                            hapticFeedback()
                            willDeleteIfReleased.toggle()
                        } else if offset.width > -deletionDistance && willDeleteIfReleased {
                            hapticFeedback()
                            willDeleteIfReleased.toggle()
                        }
                    }
                    .onEnded { _ in
                        if offset.width < -deletionDistance {
                            delete()
                        } else if offset.width < -halfDeletionDistance {
                            offset.width = -tappableDeletionWidth
                            initialOffset.width = -tappableDeletionWidth
                        } else {
                            offset = .zero
                            initialOffset = .zero
                        }
                    }
            )
            .animation(.interactiveSpring())
    }
    
    private func delete() {
        offset.width = -contentWidth
        action()
    }
    
    private func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    //MARK: Constants
    
    let deletionDistance = CGFloat(200)
    let halfDeletionDistance = CGFloat(50)
    let tappableDeletionWidth = CGFloat(100)
    
    
}

extension View {
    
    func onDelete(perform action: @escaping () -> Void) -> some View {
        self.modifier(Delete(action: action))
    }
    
}
