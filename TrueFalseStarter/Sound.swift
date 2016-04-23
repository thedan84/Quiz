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
    
    var gameSound: SystemSoundID = 0
    var rightAnswerSound: SystemSoundID = 1
    var wrongAnswerSound: SystemSoundID = 2
    
    var gameStartSound: NSURL {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        return NSURL(fileURLWithPath: pathToSoundFile!)
    }
    
    var rightSound: NSURL {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("RightSound", ofType: "wav")
        return NSURL(fileURLWithPath: pathToSoundFile!)
    }
    
    var wrongSound: NSURL {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("WrongSound", ofType: "wav")
        return NSURL(fileURLWithPath: pathToSoundFile!)
    }
    
    mutating func loadSoundWithURL(URL: NSURL, inout id: SystemSoundID) {
        
        AudioServicesCreateSystemSoundID(URL, &id)
    }
    
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