//
//  ProfileEditor.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-07-01.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile: Profile
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Username").bold()
                Divider()
                TextField("Username", text: $profile.username)
            }
            .frame(height: 60)
            VStack(alignment: .leading) {
                HStack {
                    Button(action: displayFolderPicker) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color.blue)
                            .font(.system(size: 35))
                    }
                    
                    Text("NAS Folder:")
                        .font(.headline)
                }
                Text("\(self.profile.formattedNasPath())")
                    .foregroundColor(Color.blue)
                
                Spacer()
            }
            
        }
    }
    
    func displayFolderPicker() {
        let picker = DocumentPickerViewController(
           onPick: { url in
               print("Folder URL: \(url)")
               self.processFolder(url: url)
           },
           onDismiss: {
               print("NAS folder selection prompt dismissed.")
           }
        )
           
        UIApplication.shared.windows.first?.rootViewController?.present(picker, animated: true)
    }
    
    func processFolder(url: URL) {
        profile.nasPath = url.absoluteString
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
