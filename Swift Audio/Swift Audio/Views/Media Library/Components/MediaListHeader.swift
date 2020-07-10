//
//  MediaListHeader.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-25.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI
import Combine

struct MediaListHeader: View {
    @EnvironmentObject var userData: UserData
    @State var displayMode: Int = 1
    @State var searchValue: String = ""
    
    var mediaFileManager = MediaFileManager()
    
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
                
                Button(action: promptForDirectory) {
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
    
    func promptForDirectory() {
        let picker = DocumentPickerViewController(
            onPick: self.directorySelected,
            onDismiss: self.directoryPickerDismissed
        )
        
        UIApplication.shared.windows.first?.rootViewController?.present(picker, animated: true)
    }
    
    func directorySelected(url: URL) {
        print("File URL: \(url)")
        self.userData.addMedia(self.mediaFileManager.processFolder(with: url))
    }
    
    func directoryPickerDismissed() {
        print("Prompt dismissed.")
    }
}

struct MediaListHeader_Previews: PreviewProvider {
    static var previews: some View {
        MediaListHeader()
    }
}
