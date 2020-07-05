//
//  Profile.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-07-01.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI

struct ProfileSummary: View {
    var profile: Profile
    
    var body: some View {
        List {
            Text(profile.username)
                .bold()
                .font(.title)
            
            VStack(alignment: .leading) {
                Text("NAS Folder:")
                    .font(.headline)
                Text("\(self.profile.formattedNasPath())")
                    .foregroundColor(Color.blue)
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile: Profile.default)
    }
}
