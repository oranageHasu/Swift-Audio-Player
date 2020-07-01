//
//  Media.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-20.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Media: Hashable, Codable, Identifiable {
    
    // id of the Media within the User's library
    var id: Int
    
    // Media Meta Data
    var artist: String
    var title: String
    var duration: String
    fileprivate var imageName: String
    
    // Media source
    var source: Source
    
    // User Preferences
    var isFavorite: Bool
    
    // Owner Preferences
    var isFeatured: Bool

    // Enum registering supported input streams for media
    enum Source: String, CaseIterable, Codable, Hashable {
        case digitalFile = "DigitalFile"
        case youtube = "Youtube"
    }
}

extension Media {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}
