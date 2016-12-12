//
//  SoundController.swift
//  Bout TIme
//
//  Created by Tanveer Momin on 12/12/16.
//  Copyright © 2016 Tanveer Momin. All rights reserved.
//

import Foundation
import AudioToolbox

public class SoundController {
    var correctSound: SystemSoundID = 0
    var incorrectSound: SystemSoundID = 0
    
    // Load Game Sounds
    
    func loadCorrectSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "CorrectDing", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctSound)
    }
    
    func loadIncorrectSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &incorrectSound)
    }
    
    // Play Sounds
    
    func playCorrectSound() {
        print("play Correct Sound")
        AudioServicesPlaySystemSound(correctSound)
    }
    
    func playIncorrectSound() {
        print("play Incorrect Sound")
        AudioServicesPlaySystemSound(incorrectSound)
    }
}
