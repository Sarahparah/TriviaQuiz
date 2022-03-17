//
//  MusicPlayer.swift
//  TriviaQuiz
//
//  Created by Sarah Lidberg on 2022-03-16.
//

import Foundation
import AVFoundation

class MusicPlayer {
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?
    var sound: String = ""
    var type: String = ""
    
    func startBackgroundMusic(sound: String, type: String) {
        
        if let bundle = Bundle.main.path(forResource: "\(sound)", ofType: "\(type)") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                //audioPlayer.numberOfLoops = 0
                //audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
}
