//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    //Properties
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    
//    var gameSound: SystemSoundID = 0

    var quizModel = QuizModel()
    var sound = Sound()
    
    //View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Start game
        sound.playGameStartSound()
        displayQuestion()
    }
    
    //Display the current question and determine if there are 3 or 4 possible answers
    func displayQuestion() {
        
        let question = quizModel.getRandomQuestion()["question"]
            questionField.text = question
            
            let answers = quizModel.getPossibleAnswersToRandomQuestion()
            
            if answers.count == 4 {
                answer4Button.hidden = false
                for button in [answer1Button, answer2Button, answer3Button, answer4Button] {
                    let answer = answers[button.tag - 1]
                    button.setTitle(answer, forState: .Normal)
                }
            } else if answers.count == 3 {
                answer4Button.hidden = true
                for button in [answer1Button, answer2Button, answer3Button] {
                    let answer = answers[button.tag - 1]
                    button.setTitle(answer, forState: .Normal)
                }
            }
        
        
        playAgainButton.hidden = true
    }
    
    //Display the score to the player at the end of a round
    func displayScore() {        
        // Display play again button
        playAgainButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    //Check the answer the player gave and show the correct answer if it's wrong
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let answer = quizModel.getCorrectAnswerToQuestion()
        
        if sender.titleLabel?.text! == answer {
            correctQuestions += 1
            questionField.text = "Correct!"
            sound.playRightAnswerSound()
        } else {
            questionField.text = "Sorry, wrong answer!"
            sound.playWrongAnswerSound()
            
            if quizModel.getPossibleAnswersToRandomQuestion().count == 4 {
                for button in [answer1Button, answer2Button, answer3Button, answer4Button] {
                    if button.titleLabel?.text! == answer {
                        self.showCorrectAnswerWithDelay(button, seconds: 2)
                    }
                }
            } else if quizModel.getPossibleAnswersToRandomQuestion().count == 3 {
                for button in [answer1Button, answer2Button, answer3Button] {
                    if button.titleLabel?.text! == answer {
                        self.showCorrectAnswerWithDelay(button, seconds: 2)
                    }
                }
            }
        }
        
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    //Start a new round
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        questionsAsked = 0
        correctQuestions = 0
        quizModel.questionIndicesUsed = []
        nextRound()
    }
    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    //Color the right answer green for 'x' seconds when the user chose the wrong one
    func showCorrectAnswerWithDelay(correctAnswer: UIButton, seconds: Int) {
        correctAnswer.setTitleColor(.greenColor(), forState: .Normal)
        
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            correctAnswer.setTitleColor(.whiteColor(), forState: .Normal)
            self.nextRound()
        }

    }
}

