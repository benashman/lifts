//
//  DateSectionHeader.swift
//  DateSectionHeader
//
//  Created by Benjamin Ashman on 9/3/21.
//

import SwiftUI

struct DateSectionHeader: View {
    let date: Date!
    
    var dateLabel: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        Text(dateLabel)
            .font(.system(size: 34.0, weight: .bold, design: .default))
            .foregroundColor(.primary)
            .textCase(nil)
//            .padding(.leading, -20)
//            .padding(.bottom, 4)
    }
}

//struct DateSectionHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        DateSectionHeader()
//    }
//}
