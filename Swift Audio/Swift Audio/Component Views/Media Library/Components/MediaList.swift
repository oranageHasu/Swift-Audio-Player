//
//  MediaList.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-25.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI

struct MediaList: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List {
            ForEach(self.userData.media) { media in
                NavigationLink(destination: MediaPlayer()) {
                    MediaRow(media: media)
                }
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
        .environmentObject(UserData())
    }
}
