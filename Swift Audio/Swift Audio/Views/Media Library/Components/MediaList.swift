//
//  MediaList.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-25.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI
import Combine

struct MediaList: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List(userData.networkMedia.items) { (media: Media) in
            NavigationLink(destination: MediaPlayer()) {
                MediaRow()
                    .environmentObject(media)
            }
        }
    }
}

struct MediaList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            NavigationView {
                MediaList()
            }
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}
