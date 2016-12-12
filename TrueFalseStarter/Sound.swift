//
//  Sound.swift
//  TrueFalseStarter
//
//  Created by Dennis Parussini on 23-04-16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import AudioToolbox

struct Sound {
    
    //Properties
    var gameSound: SystemSoundID = 0
    var rightAnswerSound: SystemSoundID = 1
    var wrongAnswerSound: SystemSoundID = 2
    
    //Properties which get the right sound based on path
    var gameStartSound: URL {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        return URL(fileURLWithPath: pathToSoundFile!)
    }
    
    var rightSound: URL {
        let pathToSoundFile = Bundle.main.path(forResource: "RightSound", ofType: "wav")
        return URL(fileURLWithPath: pathToSoundFile!)
    }
    
    var wrongSound: URL {
        let pathToSoundFile = Bundle.main.path(forResource: "WrongSound", ofType: "wav")
        return URL(fileURLWithPath: pathToSoundFile!)
    }
    
    //Helper function to load the right sound from the bundle url
    mutating func loadSoundWithURL(_ URL: Foundation.URL, id: inout SystemSoundID) {
        AudioServicesCreateSystemSoundID(URL as CFURL, &id)
    }
    
    //Helper functions to play the right sound
    mutating func playGameStartSound() {
        loadSoundWithURL(gameStartSound, id: &gameSound)
        AudioServicesPlaySystemSound(gameSound)
    }
    
    mutating func playRightAnswerSound() {
        loadSoundWithURL(rightSound, id: &rightAnswerSound)
        AudioServicesPlaySystemSound(rightAnswerSound)
    }
    
    mutating func playWrongAnswerSound() {
        loadSoundWithURL(wrongSound, id: &wrongAnswerSound)
        AudioServicesPlaySystemSound(wrongAnswerSound)
    }
    
}
