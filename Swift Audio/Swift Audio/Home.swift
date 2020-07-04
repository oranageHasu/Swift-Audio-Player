//
//  ContentView.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-20.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var user: UserData
    
    var profileButton: some View {
        Button(action: { print("pressed") }) {
            NavigationLink(destination: ProfileHost()) {
                Image(systemName: "person.crop.circle")
                    .imageScale(.large)
                    .accessibility(label: Text("User Profile"))
                    .padding()
                    .foregroundColor(Color.blue)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                MediaLibrary()
                    .environmentObject(user)
                    .navigationBarTitle(Text("Music Library"))
                    .background(Color(UIColor.systemBackground))
                    .navigationBarItems(trailing: profileButton)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(UserData())
    }
}
