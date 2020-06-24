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

    // UI Display
    @Published var showFavoritesOnly = false
    
    // Media Data
    @Published var media = mediaData
}
