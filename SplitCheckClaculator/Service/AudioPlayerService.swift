//
//  AudioPlayerService.swift
//  SplitCheckClaculator
//
//  Created by Junior Silva on 23/01/23.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
    func playSound()
}

final class DefaultAudioPlayer: AudioPlayerService {
    private var player: AVAudioPlayer?
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "click", ofType: ".m4a") else { return }
        let url = URL(filePath: path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
}
