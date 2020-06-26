//
//  MediaLibrary.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-24.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI

struct MediaLibrary: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            VStack {
                MediaListHeader()
                MediaList()
                    .environmentObject(self.userData)
            }
            .navigationBarTitle(Text("Music Library"))
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct MediaLibrary_Previews: PreviewProvider {
    static var previews: some View {
        MediaLibrary()
            .environmentObject(UserData())
    }
}
