//
//  SwipeToDelete.swift
//  Lifts
//
//  Created by Benjamin Ashman on 1/29/22.
//

import Foundation
import SwiftUI

struct swipeToDeleteModifier: ViewModifier {
    @State var entry: Entry
    @State var viewState = CGSize.zero
    @State var isSwiped = false
    @State var backgroundColor = Color.red
    
    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            content
                .offset(x: min(0, viewState.width), y: .zero)
                .highPriorityGesture(
                    DragGesture()
                        .onChanged(onChanged(value:))
                        .onEnded(onEnded(value:))
                )
        }
    }
    
    func onChanged(value: DragGesture.Value) {
        // log which row is being changed
        print(self)
        
        // If we're already in a swiped state, account for that in drag distance
        if isSwiped {
            viewState = CGSize(width: value.translation.width - 90, height: .zero)
        } else {
            viewState = value.translation
        }
    }
    
    func onEnded(value: DragGesture.Value) {
        withAnimation(.easeOut) {
            
            // If we swipe over halfway, delete the item immediately
            if -value.translation.width > UIScreen.main.bounds.width / 2 {
                viewState = CGSize(width: -1000, height: .zero)
                DataHelper.deleteEntry(entry)
            }
            
            // If we swipe just enough, expand to show full delete control
            else if viewState.width < -50 {
                isSwiped = true
                viewState = CGSize(width: -90, height: .zero)
            }
            
            // Otherwise, just reset back to where it started
            else {
                isSwiped = false
                viewState = .zero
            }
        }
    }
}

extension View {
    func swipeToDelete(entry: Entry) -> some View {
        modifier(swipeToDeleteModifier(entry: entry))
    }
}
