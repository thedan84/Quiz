//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    @IBOutlet var threeAnswersButtonCollection: [UIButton]!
    @IBOutlet var fourAnswersButtonCollection: [UIButton]!
    
    //Properties
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    
    var quizManager = QuizManager()
    
    //View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Start game
        Sound.playGameStartSound()
        displayQuestion()
    }
    
    //Display the current question and determine if there are 3 or 4 possible answers
    func displayQuestion() {
        
        let question = quizManager.getRandomQuestion()
            questionField.text = question?.question
            
            let answers = quizManager.getPossibleAnswersToRandomQuestion()
            
            if answers.count == 4 {
                answer4Button.isHidden = false
                for button in fourAnswersButtonCollection {
                    let answer = answers[(button.tag) - 1]
                    button.setTitle(answer, for: UIControl.State())
                }
            } else if answers.count == 3 {
                answer4Button.isHidden = true
                for button in threeAnswersButtonCollection {
                    let answer = answers[(button.tag) - 1]
                    button.setTitle(answer, for: UIControl.State())
                }
            }
        
        playAgainButton.isHidden = true
    }
    
    //Display the score to the player at the end of a round
    func displayScore() {        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    //Check the answer the player gave and show the correct answer if it's wrong
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let answer = quizManager.getCorrectAnswerToQuestion()
        
        if sender.titleLabel?.text! == answer {
            correctQuestions += 1
            questionField.text = "Correct!"
            
            //Play right answer sound
            Sound.playRightAnswerSound()
        } else {
            questionField.text = "Sorry, wrong answer!"
            
            //Play wrong answer sound
            Sound.playWrongAnswerSound()
            
            if quizManager.getPossibleAnswersToRandomQuestion().count == 4 {
                for button in fourAnswersButtonCollection {
                    if button.titleLabel?.text! == answer {
                        self.showCorrectAnswerWithDelay(button, seconds: 2)
                    }
                }
            } else if quizManager.getPossibleAnswersToRandomQuestion().count == 3 {
                for button in threeAnswersButtonCollection {
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
        quizManager.questionIndicesUsed = []
        nextRound()
    }
    
    // MARK: Helper Methods
    
    func delay(for seconds: Int, action: @escaping () -> Void) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            action()
        }
    }
    
    func loadNextRoundWithDelay(seconds: Int) {
        delay(for: seconds) {
            self.nextRound()
        }
    }
    
    //Color the right answer green for 'x' seconds when the user chose the wrong one
    func showCorrectAnswerWithDelay(_ correctAnswer: UIButton, seconds: Int) {
        correctAnswer.setTitleColor(.green, for: UIControl.State())
        delay(for: seconds) {
            correctAnswer.setTitleColor(.white, for: UIControl.State())
            self.nextRound()
        }
    }
}
