//
//  ContentView.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-20.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI

struct Home: View {
    var media: Media
    
    var body: some View {
        MediaPlayer()
            .environmentObject(UserData())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home(media: mediaData[0])
    }
}
