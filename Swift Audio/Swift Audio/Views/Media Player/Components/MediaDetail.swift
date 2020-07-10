//
//  MediaDetail.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-20.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI

struct MediaDetail: View {
    var media: Media
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text(media.artist ?? "N/A")
                    .font(.title)
                Text(media.title ?? "N/A")
            }
            Spacer()
        }
        .padding()
    }
}

struct MediaDetail_Previews: PreviewProvider {
    static var previews: some View {
        MediaDetail(media: mediaData[0])
    }
}
