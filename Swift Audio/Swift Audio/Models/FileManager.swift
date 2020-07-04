//
//  FileManager.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-26.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import Foundation
import UIKit
import CoreServices

let mediaFromNetwork: [URL] = [] //readFiles()

func readFiles() -> [Media] {
    
    let media: [Media] = []
    let fileManager = FileManager()
    
    print("Current directory: \(fileManager.currentDirectoryPath)")
    print("test")
    
    let keys: [URLResourceKey] = [.volumeNameKey]
    let result = fileManager.mountedVolumeURLs(includingResourceValuesForKeys: keys, options: [])
    
    if result != nil {
     
        result!.forEach { url in
            print(url)
        }
        
    } else {
        print("No URLs discovered.")
    }
    
    return media
    
}
