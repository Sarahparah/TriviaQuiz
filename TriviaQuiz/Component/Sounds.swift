//
//  AVSoundEffects.swift
//  TriviaQuiz
//
//  Created by Joanne Yager on 2022-03-17.
//

import Foundation
import AVFoundation

 class Sounds {

   static var audioPlayer:AVAudioPlayer?

     static func playSounds(soundfile: String, delay: Double) {

       if let path = Bundle.main.path(forResource: soundfile, ofType: nil){

           do{

               audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
               audioPlayer?.prepareToPlay()
               DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
                   audioPlayer?.play()
               }

           } catch {
               print("Error")
           }
       }
    }
 }

