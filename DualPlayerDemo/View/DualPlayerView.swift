//
//  AudioModuleView.swift
//  audio-app-demo
//
//  Created by Kate W. on 5/3/24.
//

import SwiftUI
import AVFoundation

struct DualPlayerView: View {
    @StateObject private var play1 = PlayerViewModel(url: URL(string: "https://github.com/xilu-wang/test-audio-files/raw/main/Sample-6s.mp3")!)
    @StateObject private var play2 = PlayerViewModel(url: URL(string: "https://github.com/prof3ssorSt3v3/media-sample-files/raw/master/jimmy-coffee.mp3")!)
    
    var body: some View {
        VStack {
            // player 1
            Slider(value: $play1.progress, in: 0...1, step: 0.01)
                .padding()
            Text("Audio #1")
                .font(.headline)
                .padding()
            HStack {
                Button(action: play1.play) {
                    Image(systemName: "play.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Button(action: play1.pause) {
                    Image(systemName: "pause.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Button(action: play1.stop) {
                    Image(systemName: "stop.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            .padding()
            
            // player 2
            Text("Audio #2")
                .font(.headline)
                .padding()
            Slider(value: $play2.progress, in: 0...1, step: 0.01)
                .padding()
            HStack {
                Button(action: play2.play) {
                    Image(systemName: "play.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Button(action: play2.pause) {
                    Image(systemName: "pause.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Button(action: play2.stop) {
                    Image(systemName: "stop.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            .padding()
        }
    }
}

struct DualPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        DualPlayerView()
    }
}
