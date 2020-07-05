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
    @Environment(\.colorScheme) var colorScheme
    
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
                Text("\(timeIntervalToString(timeInterval: playTime))")
                    .foregroundColor(getButtonColor(colorScheme))
                    .padding(.leading)
                    .onReceive(timer) { _ in
                        self.updatePlayTime()
                    }
                
                Slider(value: $playTime, in: 0...songDuration)
                    
                Text("\(timeIntervalToString(timeInterval: songDuration))")
                    .foregroundColor(getButtonColor(colorScheme))
                    .padding(.trailing)
            }
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    self.isShuffleOn.toggle()
                })  {
                    
                    if isShuffleOn {
                        Image(systemName: "shuffle")
                            .shuffleAudioButtonImage(with: Color.blue)
                    } else {
                        Image(systemName: "shuffle")
                            .shuffleAudioButtonImage(with: getButtonColor(colorScheme))
                    }
                }
                
                Button(action: {
                    self.lastSong()
                })  {
                    Image(systemName: "backward.end.fill")
                        .audioButtonImage(with: getButtonColor(colorScheme))
                }
                
                Button(action: {
                    print("Rewind clicked.")
                })  {
                    Image(systemName: "backward.fill")
                        .audioButtonImage(with: getButtonColor(colorScheme))
                }
                
                Button(action: {
                    self.stopSong()
                })  {
                    Image(systemName: "stop.fill")
                        .audioButtonImage(with: getButtonColor(colorScheme))
                }
                
                Button(action: {
                    self.playPressed()
                })  {
                    if !self.isPaused && self.isPlaying {
                        Image(systemName: "pause.fill")
                            .playAudioButtonImage()
                    } else {
                        Image(systemName: "play.fill")
                            .playAudioButtonImage()
                    }
                }
                
                Button(action: {
                    print("Fast forward clicked.")
                })  {
                    Image(systemName: "forward.fill")
                        .audioButtonImage(with: getButtonColor(colorScheme))
                }
                
                Button(action: {
                    self.nextSong()
                })  {
                    Image(systemName: "forward.end.fill")
                        .audioButtonImage(with: getButtonColor(colorScheme))
                }
                
                Button(action: {
                    self.isRepeatOn.toggle()
                })  {
                    if self.isRepeatOn {
                        Image(systemName: "repeat")
                            .randomAudioButtonImage(with: Color.blue)
                    } else {
                        Image(systemName: "repeat")
                            .randomAudioButtonImage(with: getButtonColor(colorScheme))
                    }
                }
                                
                Spacer()
            }
        }
    }
    
    func playPressed() {
        if self.player == nil || !self.player.isPlaying {
            
            if self.isPaused {
              self.resumeSong()
            } else {
                self.playSong()
            }
            
        } else {
            self.pauseSong()
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

        // Reset the Curr Index back to 0 if the user hits the end of the fake library
        if self.currentSongIndex < self.songs.count-1 {
            self.currentSongIndex += 1
        } else {
            self.currentSongIndex = 0
        }
        
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
            // Initialize the Audio Player
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
    
    func updatePlayTime() {
        if self.isPlaying {
            if let currentTime = self.player?.currentTime {
                self.playTime = currentTime
            }
        } else {
            self.isPlaying = false
            self.timer.upstream.connect().cancel()
        }
    }
    
    func timeIntervalToString(timeInterval: TimeInterval) -> String {
        let time = timeFormat.string(from: Date(timeIntervalSince1970: timeInterval))
        return time
    }
    
    private func getButtonColor(_ colorScheme: ColorScheme) -> Color {
        var retval = Color.white
        
        if colorScheme == .light {
            retval = Color.black
        }
        
        return retval
    }
}

struct MediaButtons_Previews: PreviewProvider {
    static var previews: some View {
        return MediaButtons(currentSongIndex: .constant(0))
    }
}

extension Image {
    
    func audioButtonImage(with color: Color) -> some View {
        self
            .foregroundColor(color)
            .font(.system(size: 25))
            .padding(.trailing, 5)
    }
    
    func playAudioButtonImage() -> some View {
        self
            .foregroundColor(Color.blue)
            .font(.system(size: 35))
            .padding(.trailing, 5)
    }
    
    func shuffleAudioButtonImage(with color: Color) -> some View  {
        self
            .foregroundColor(color)
            .padding(.trailing, 30)
    }
    
    func randomAudioButtonImage(with color: Color) -> some View  {
        self
            .foregroundColor(color)
            .padding(.leading, 30)
    }

}
