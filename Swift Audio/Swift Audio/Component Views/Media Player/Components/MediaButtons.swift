//
//  MediaButtons.swift
//  Swift Audio
//
//  Created by Blair Petrachek on 2020-06-20.
//  Copyright © 2020 Blair Petrachek. All rights reserved.
//

import SwiftUI
import AVKit

struct MediaButtons: View {
    // Temp Variables
    var songs = ["Men At Work - Who Can It Be Now.flac","The Reklaws - Old Country Soul.mp3"]
    @Binding var currentSongIndex: Int

    let dot = "."
    let mp3 = "mp3"
    let flac = "flac"
    
    // Audio States
    @State var isShuffleOn = false
    @State var isRepeatOn = false
    @State var isPaused = false
    @State var isPlaying = false
    
    // Audio Player
    @State var player: AVAudioPlayer!
    @State var playTime: TimeInterval = 0.0
    @State var songDuration: TimeInterval = 0.0
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var timeFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        return formatter
    }
    
    var body: some View {
        return VStack {
            HStack {
                Text("\(timeIntervalToString(timeInterval: self.playTime))")
                    .foregroundColor(Color.black)
                    .padding(.leading)
                    .onReceive(self.timer) { _ in
                        if self.isPlaying {
                            if let currentTime = self.player?.currentTime {
                                self.playTime = currentTime
                            }
                        } else {
                            self.isPlaying = false
                            self.timer.upstream.connect().cancel()
                        }
                    }
                
                Slider(value: self.$playTime, in: 0...self.songDuration)
                    
                Text("\(timeIntervalToString(timeInterval: self.songDuration))")
                    .foregroundColor(Color.black)
                    .padding(.trailing)
            }
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    self.isShuffleOn.toggle()
                })  {
                    
                    if self.isShuffleOn {
                        Image(systemName: "shuffle")
                            .foregroundColor(Color.blue)
                            .padding(.trailing, 30)
                    } else {
                        Image(systemName: "shuffle")
                            .foregroundColor(Color.black)
                            .padding(.trailing, 30)
                    }
                }
                
                Button(action: {
                    self.lastSong()
                })  {
                    Image(systemName: "backward.end.fill")
                        .foregroundColor(Color.black)
                        .font(.system(size: 25))
                        .padding(.trailing, 5)
                }
                
                Button(action: {
                    print("Rewind clicked.")
                })  {
                    Image(systemName: "backward.fill")
                        .foregroundColor(Color.black)
                        .font(.system(size: 25))
                        .padding(.trailing, 5)
                }
                
                Button(action: {
                    self.stopSong()
                })  {
                    Image(systemName: "stop.fill")
                        .foregroundColor(Color.black)
                        .font(.system(size: 25))
                        .padding(.trailing, 5)
                }
                
                Button(action: {
                    
                    if self.player == nil || !self.player.isPlaying {
                        
                        if self.isPaused {
                          self.resumeSong()
                        } else {
                            self.playSong()
                        }
                        
                    } else {
                        self.pauseSong()
                    }
                    
                })  {
                    if !self.isPaused && self.isPlaying {
                        Image(systemName: "pause.fill")
                            .foregroundColor(Color.blue)
                            .font(.system(size: 35))
                            .padding(.trailing, 5)
                    } else {
                        Image(systemName: "play.fill")
                            .foregroundColor(Color.blue)
                            .font(.system(size: 35))
                            .padding(.trailing, 5)
                    }
                }
                
                Button(action: {
                    print("Fast forward clicked.")
                })  {
                    Image(systemName: "forward.fill")
                        .foregroundColor(Color.black)
                        .font(.system(size: 25))
                        .padding(.trailing, 5)
                }
                
                Button(action: {
                    self.nextSong()
                })  {
                    Image(systemName: "forward.end.fill")
                        .foregroundColor(Color.black)
                        .font(.system(size: 25))
                }
                
                Button(action: {
                    self.isRepeatOn.toggle()
                })  {
                    
                    if self.isRepeatOn {
                        Image(systemName: "repeat")
                            .foregroundColor(Color.blue)
                            .padding(.leading, 30)
                    } else {
                        Image(systemName: "repeat")
                            .foregroundColor(Color.black)
                            .padding(.leading, 30)
                    }
            
                }
                                
                Spacer()
            }
            
            /*
            Text("Current Index: \(self.currentSongIndex)")
                .foregroundColor(.black)
            Text("Library Size: \(self.songs.count)")
                .foregroundColor(.black)
            */
        }
    }
    
    func pauseSong() {
        player.pause()
        self.isPaused.toggle()
        self.playTime = self.player.currentTime
    }
    
    func resumeSong() {
        player.play()
        self.isPaused = false
    }
    
    func stopSong() {
        if self.isPlaying {
            player.stop()
            self.isPlaying = false
        }
    }
    
    func lastSong() {
        // Stop playing the current song
        self.stopSong()
        
        // Reset the Curr Index back to Array length if the user hits the start of the fake library
        if currentSongIndex > 0 {
            currentSongIndex -= 1
        } else {
            currentSongIndex = songs.count-1
        }
        
        // Play the new song
        self.playSong()
    }
    
    func nextSong() {
        // Stop playing the current song
        self.stopSong()

        print("Before: \(self.currentSongIndex)")
        
        // Reset the Curr Index back to 0 if the user hits the end of the fake library
        if self.currentSongIndex < self.songs.count-1 {
            self.currentSongIndex += 1
        } else {
            self.currentSongIndex = 0
        }
        
        print("After: \(self.currentSongIndex)")
        
        // Play the new song
        self.playSong()
    }
    
    func playSong() {
        var songExt = ""
        var songName = ""
        
        if songs[currentSongIndex].hasSuffix(mp3) {
            songExt = mp3
        } else {
            songExt = flac
        }
        
        songName = String(songs[currentSongIndex].dropLast(songExt.count+1))
        
        let path = Bundle.main.path(forResource: songName, ofType: songExt)!
        let url = URL(fileURLWithPath: path)
        
        do {
            // Establish the Audio Player
            self.player = try AVAudioPlayer(contentsOf: url)
            
            // Play the song
            player.play()
            
            // Stack state
            self.isPlaying = player.isPlaying
            self.isPaused = false
            
            self.songDuration = player.duration
            self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        } catch {
            print("Error Playing Music.")
            print(error)
        }
    }
    
    func timeIntervalToString(timeInterval: TimeInterval) -> String {
        let time = timeFormat.string(from: Date(timeIntervalSince1970: timeInterval))
        return time
    }
}

struct MediaButtons_Previews: PreviewProvider {
    static var previews: some View {
        return MediaButtons(currentSongIndex: .constant(0))
    }
}
