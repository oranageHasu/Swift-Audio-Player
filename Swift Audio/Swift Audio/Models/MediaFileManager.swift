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
import Combine

struct MediaFileManager {
    
    func processFolder(with url: URL) -> MediaCollection {
        let mediaFromNetwork = MediaCollection()
        var error: NSError? = nil
        
        guard url.startAccessingSecurityScopedResource() else {
            
            // Failure!
            print("Failed accessing Directory.")
            return mediaFromNetwork
            
        }
        
        // Ensure the security-scope resource is released once finished
        defer { url.stopAccessingSecurityScopedResource() }
        
        // Use File Coordination for reading the URLs contents
        NSFileCoordinator().coordinate(readingItemAt: url, error: &error, byAccessor: { (url) in
            
            let keys: [URLResourceKey] = [.nameKey, .isDirectoryKey]
            var tempMedia: Media
            var index = 0

            // Get an enumerator for the Directory's content
            guard let fileList =
                FileManager.default.enumerator(at: url, includingPropertiesForKeys: keys) else {
                    print("ERROR - Unable to access contents of \(url.path)")
                    return
            }
            
            for case let file as URL in fileList {
                
                // Start accessing the Directory content's security-scoped URL
                guard url.startAccessingSecurityScopedResource() else {
                    
                    // Failure!
                    print("Failed accessing the directory URL content for \(file.path)")
                    continue
                    
                }
                
                // Ensure the security-scope resource is released once finished
                defer { url.stopAccessingSecurityScopedResource() }
                
                // Act on the file!
                // For now, simply parse the file name, build a simple Media instance, and display that
                // We'll do better next iteration
                let filename = file.lastPathComponent
                let split = filename.components(separatedBy: " - ")
                
                if (split.count == 2) {
                    var removeCharAmt = 4
                    if split[0].contains(".flac") {
                        removeCharAmt = 5
                    }
                    
                    let songNameWithoutExt = String(split[1].dropLast(removeCharAmt))
                    
                    tempMedia = Media(artist: split[0], title: songNameWithoutExt, duration: "0:00")
                    tempMedia.id = UUID().hashValue
                    mediaFromNetwork.items.append(tempMedia)
                    
                    print("Creating Array: \(mediaFromNetwork.items[index].artist)")
                    print("Creating Array: \(mediaFromNetwork.items[index].title)")
                    
                    index += 1
                }
            }
        })
        
        return mediaFromNetwork
    }
}
