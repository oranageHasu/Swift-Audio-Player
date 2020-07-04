//
//  Profile.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-07-01.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//
import Foundation

struct Profile {
    
    // Constant used to determine SMB NAS music directory
    let smbNasDirectory = "com.apple.filesystems.smbclientd"
    
    var username: String
    var nasPath: String

    static let `default` = Self(username: "oranagehasu", nasPath: "")
    
    init(username: String, nasPath: String) {
        self.username = username
        self.nasPath = nasPath
    }
    
    func formattedNasPath() -> String {
        var retval: String = "N/A"
        
        if nasPath.count > 0 {
            // Check if this is a SMB NAS path
            if nasPath.contains(smbNasDirectory) {
                let smbNasRange = nasPath.range(of: smbNasDirectory)
                let range = smbNasRange!.upperBound..<nasPath.endIndex
                retval = String(nasPath[range]).components(separatedBy: "/").dropFirst(2).joined(separator: "/")
            } else {
                let url = URL(string: nasPath)
                
                if let safeURL = url {
                    retval = safeURL.lastPathComponent
                }
            }
        }
        
        return retval
    }
}
