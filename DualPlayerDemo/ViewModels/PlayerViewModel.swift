//
//  PlayerModel.swift
//  audio-app-demo
//
//  Created by Kate W. on 5/3/24.
//

import Foundation
import SwiftUI
import AVFoundation

class PlayerViewModel: ObservableObject {
    @Published var player: AVPlayer?
    @Published var progress: Double = 0.0
    
    private var timeObserverToken: Any?
    
    init(url: URL) {
        // Initialize the player with a URL
        player = AVPlayer(url: url)
        addPeriodicTimeObserver()
        setupAudioSession()
    }
    
    func play() {
        player?.play()
        setupAudioSession()  // Ensure the audio session is active
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: CMTime.zero)
        progress = 0.0
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session.")
        }
    }
    
    private func addPeriodicTimeObserver() {
        let interval = CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self else { return }
            guard let duration = self.player?.currentItem?.duration else { return }
            let currentTime = CMTimeGetSeconds(time)
            let totalDuration = CMTimeGetSeconds(duration)
            self.progress = totalDuration.isFinite ? currentTime / totalDuration : 0.0
        }
    }
    
    deinit {
        if let timeObserverToken = timeObserverToken {
            player?.removeTimeObserver(timeObserverToken)
        }
        try? AVAudioSession.sharedInstance().setActive(false)
    }
}
