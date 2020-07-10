//
//  UserData.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-20.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//
//
// Abstract:
// A model object that stores app data.

import Combine
import SwiftUI

final class UserData: ObservableObject {
    // Play State Control
    @Published var isRandomOn = true
    @Published var isRepeatOn = true
    
    // User Profile
    @Published var profile = Profile.default
    
    // Media Data
    @Published var media = mediaData
    @Published var networkMedia = MediaCollection()
    
    func addMedia(_ media: MediaCollection) {
        
        print("Before main thread invoke.")
        
        DispatchQueue.main.async {
            self.networkMedia = media
            print(self.networkMedia.items[0].title)
            print(self.networkMedia.items[1].title)
        }
        
        print("Count: \(networkMedia.items.count)")
    }
}
