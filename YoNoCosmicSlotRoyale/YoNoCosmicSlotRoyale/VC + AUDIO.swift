//
//  VC + AUDIO.swift
//  Zygotastic Slot Winline
//
//  Created by SSS CosmicSlot Royale on 13/08/24.
//

import Foundation
import UIKit
import AVFoundation


extension UIViewController{
    
    static var audioPlayer: AVAudioPlayer?
    
    func playSound(name : String, type: String = ".mp3") {
        
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            let url = URL(fileURLWithPath: path)
            
            do {
                UIViewController.audioPlayer = try AVAudioPlayer(contentsOf: url)
                UIViewController.audioPlayer?.play()
            } catch {
                // Handle the error here
                print("Couldn't load file")
            }
        }
    }
    
}
