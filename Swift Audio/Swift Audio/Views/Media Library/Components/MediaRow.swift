//
//  MediaRow.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-25.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI

struct MediaRow: View {
    @EnvironmentObject var media: Media
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.media.artistFormatted())
                    .font(.headline)
                    .foregroundColor(Color.blue)
                Text(self.media.title)
                    .font(.subheadline)
            }
            .padding(.leading, 2)
            
            Spacer()
            
            Text(self.media.duration)
                .padding(.trailing)
                .font(.headline)
        }
    }
}

struct MediaRow_Previews: PreviewProvider {
    static var previews: some View {
        MediaRow()
            .environmentObject(mediaData[0])
    }
}
