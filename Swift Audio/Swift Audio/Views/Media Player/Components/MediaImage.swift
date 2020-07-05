//
//  MediaImage.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-20.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI

struct MediaImage: View {
    @Environment(\.colorScheme) var colorScheme
    
    var image: Image

    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: 250, height: 250)
            .clipShape(Circle())
            .overlay(Circle().stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 4))
            .shadow(radius: 10)
    }
}

struct MediaImage_Previews: PreviewProvider {
    static var previews: some View {
        MediaImage(image: UserData().media[0].image)
    }
}
