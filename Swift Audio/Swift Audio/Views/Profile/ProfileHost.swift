//
//  ProfileHost.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-07-01.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var mode
    @EnvironmentObject var user: UserData
    @State var profile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if self.mode?.wrappedValue == .active {
                    Button("Cancel") {
                        self.profile = self.user.profile
                        self.mode?.animation().wrappedValue = .inactive
                    }
                }
                
                Spacer()
                
                EditButton()
            }
            
            if self.mode?.wrappedValue == .inactive {
                ProfileSummary(profile: user.profile)
            } else {
                ProfileEditor(profile: self.$profile)
                    .onAppear {
                        self.profile = self.user.profile
                    }
                    .onDisappear {
                        self.user.profile = self.profile
                    }
            }
            
            Spacer()
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(UserData())
    }
}
