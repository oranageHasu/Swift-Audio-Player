//
//  Media.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-20.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class MediaCollection: ObservableObject {
    @Published var items: [Media] = []
}

class Media: ObservableObject, Identifiable {
    // id of the Media within the User's library
    var id: Int?
    
    // Media Meta Data
    @Published var artist: String = "Default"
    @Published var title: String = "Default"
    @Published var duration: String = "Default"
    fileprivate var imageName: String = ""
    
    // Media source
    var source: Source?
    
    // User Preferences
    var isFavorite: Bool?
    
    // Owner Preferences
    var isFeatured: Bool?

    // Enum registering supported input streams for media
    enum Source: String, CaseIterable, Codable {
        case digitalFile = "DigitalFile"
        case youtube = "Youtube"
    }
    
    required init(from decoder: Decoder) throws {
        print("error decoding.")
    }
    
    func encode(to encoder: Encoder) throws {
        print("error encoding")
    }
    
    init(artist: String, title: String, duration: String) {
        self.artist = artist
        self.title = title
        self.duration = duration
    }
    
    func artistFormatted() -> String {
        return self.artist
    }
}

extension Media {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}
