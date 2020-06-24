//
//  MediaPlayer.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-20.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI

struct MediaPlayer: View {
    @EnvironmentObject private var user: UserData
    @State var currentSongIndex = 0
    
    var body: some View {
        VStack() {
            Spacer()
            
            MediaImage(image: self.user.media[currentSongIndex].image)
            
            MediaDetail(media: self.user.media[currentSongIndex])
            
            MediaButtons(currentSongIndex: $currentSongIndex)
            
            Spacer()
        }
    }
}

struct MediaPlayer_Previews: PreviewProvider {
    static var previews: some View {
        MediaPlayer()
            .environmentObject(UserData())
    }
}
