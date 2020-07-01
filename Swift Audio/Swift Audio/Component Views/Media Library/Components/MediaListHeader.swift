//
//  MediaListHeader.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-25.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI
import Combine
import AVKit    // Remove after!

struct MediaListHeader: View {
    @State var displayMode: Int = 1
    @State var searchValue: String = ""
    
    // Remove AFTER!
    @State var player: AVAudioPlayer!
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker("Filters", selection: self.$displayMode) {
                Text("Tracks").tag(1)
                Text("Artists").tag(2)
                Text("Albums").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.leading, 5)
            .padding(.trailing, 5)
            
            HStack {
                TextField("Search...", text: self.$searchValue)
                    .padding(.leading, 5)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    
                    print("engaging file picker.")
                    
                    let picker = DocumentPickerViewController(
                            onPick: { url in
                                print("File URL: \(url)")
                                self.processFolder(url: url)
                            },
                            onDismiss: {
                                print("Prompt dismissed.")
                            }
                    )
                    
                    UIApplication.shared.windows.first?.rootViewController?.present(picker, animated: true)
                }) {
                    Image(systemName: "plus.circle.fill")
                    .font(.system(size: 25))
                    .padding(.trailing, 10)
                    .padding(.leading, 5)
                }
            }
            
            HStack {
                Text("Artist")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.blue)
                    .padding(.leading, 5)
                
                Spacer()
                
                Text("Duration")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.blue)
                    .padding(.trailing, 5)
            }
        }
        .padding(.top, 10)
    }
    
    func processFolder(url: URL) {
        var error: NSError? = nil
        
        guard url.startAccessingSecurityScopedResource() else {
            
            // Failure!
            print("Failed accessing Directory.")
            return
            
        }
        
        // Ensure the security-scope resource is released once finished
        defer { url.stopAccessingSecurityScopedResource() }
        
        // Use File Coordination for reading the URLs contents
        NSFileCoordinator().coordinate(readingItemAt: url, error: &error, byAccessor: { (url) in
            
            let keys: [URLResourceKey] = [.nameKey, .isDirectoryKey]
            
            // Stop the player
            self.player = nil
            
            do {
                
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
                    print("Song: \(file.path)")
                    
                    if self.player == nil && file.isFileURL {
                        // Establish the Audio Player
                        self.player = try AVAudioPlayer(contentsOf: file)

                        // Play the song
                        player.play()
                    }
                }
                
            }
            catch {
                print("ERROR!")
            }
            
        })
    }
}

struct MediaListHeader_Previews: PreviewProvider {
    static var previews: some View {
        MediaListHeader()
    }
}
