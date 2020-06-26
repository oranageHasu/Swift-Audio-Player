//
//  MediaListHeader.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-25.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI

struct MediaListHeader: View {
    @State var displayMode: Int = 1
    @State var searchValue: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker("Filters", selection: self.$displayMode) {
                Text("Tracks").tag(1)
                Text("Artists").tag(2)
                Text("Albums").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            TextField("Search...", text: self.$searchValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Text("Artist")
                    .font(.title)
                    .foregroundColor(Color.blue)
                    .padding(.leading, 5)
                
                Spacer()
                
                Text("Duration")
                    .font(.title)
                    .foregroundColor(Color.blue)
                    .padding(.trailing, 5)
            }
        }
        .padding(.top, 10)
    }
}

struct MediaListHeader_Previews: PreviewProvider {
    static var previews: some View {
        MediaListHeader()
    }
}
