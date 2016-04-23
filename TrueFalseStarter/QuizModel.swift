//
//  QuizModel.swift
//  TrueFalseStarter
//
//  Created by Dennis Parussini on 17-04-16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import GameKit

struct QuizModel {
    
    //Properties to keep track of question index and questions already asked
    var questionIndex = 0
    var questionIndicesUsed = [Int]()
    
    //Arrays for questions and answers
    let questions = [
        ["question": "When was Apple Inc. founded?", "answer": "1976"],
        ["question": "Which was NOT among the first computers Apple built?", "answer": "Macintosh"],
        ["question": "How many Steves were involved in the foundation of Apple Inc.?", "answer": "2"],
        ["question": "When was the first iPhone announced?", "answer": "2007"],
        ["question": "How many iPhone apps are on the App Store?", "answer": "More than a million"],
        ["question": "How was Steve Jobs middlename?", "answer": "Paul"],
        ["question": "When was the first iPad announced?", "answer": "2010"]
    ]
    
    let answers = [
        ["1975", "1976", "1977"],
        ["Apple I", "Macintosh", "Apple Lisa", "Apple II"],
        ["1", "2", "3", "None"],
        ["2006", "2007", "2008"],
        ["A few thousand", "More than a hundred thousand", "More than a million"],
        ["Paul", "Peter", "Pablo"],
        ["2008", "2009", "2010", "2011"]
    ]
    
    //Function which returns a random question and checks if the question has been asked before
    mutating func getRandomQuestion() -> [String: String] {
        var question = [String: String]()
        
        var randomInt = createRandomInt()
        
        if questionIndicesUsed.isEmpty || !questionIndicesUsed.contains(randomInt) {
            questionIndex = randomInt
            questionIndicesUsed.append(randomInt)
            question = questions[randomInt]
        } else {
            for index in questionIndicesUsed {
                while randomInt == index {
                    randomInt = createRandomInt()
                    questionIndex = randomInt
                    questionIndicesUsed.append(randomInt)
                    question = questions[randomInt]
                }
            }
        }
        
        return question
    }
    
    //Helper method to create a random integer
    func createRandomInt() -> Int {
        return GKRandomSource.sharedRandom().nextIntWithUpperBound(questions.count)
    }
    
    //Function which returns possible answers in regard of the current question index
    func getPossibleAnswersToRandomQuestion() -> [String] {
        return answers[questionIndex]
    }
    
    //Function which returns the correct answer to the current question
    func getCorrectAnswerToQuestion() -> String {
        let question = questions[questionIndex]
        let answer = question["answer"]
        return answer!
    }
}