//
//  QuizManager.swift
//  TrueFalseStarter
//
//  Created by Dennis Parussini on 02.08.19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import GameKit

struct QuizManager {
    
    //Properties to keep track of question index and questions already asked
    var questionIndex = 0
    var questionIndicesUsed = [Int]()
    
    //Arrays for questions and answers
    let questions = [
        Question(question: "When was Apple Inc. founded?", answer: "1976", possibleAnswers: ["1975", "1976", "1977"]),
        Question(question: "Which was NOT among the first computers Apple built?", answer: "Macintosh", possibleAnswers: ["Apple I", "Macintosh", "Apple Lisa", "Apple II"]),
        Question(question: "How many Steves were involved in the foundation of Apple Inc.?", answer: "2", possibleAnswers: ["1", "2", "3", "None"]),
        Question(question: "When was the first iPhone announced?", answer: "2007", possibleAnswers: ["2006", "2007", "2008"]),
        Question(question: "How many iPhone apps are on the App Store?", answer: "More than a million", possibleAnswers: ["A few thousand", "More than a hundred thousand", "More than a million"]),
        Question(question: "What was Steve Jobs' middlename?", answer: "Paul", possibleAnswers: ["Paul", "Peter", "Pablo"]),
        Question(question: "When was the first iPad announced?", answer: "2010", possibleAnswers: ["2008", "2009", "2010", "2011"])
    ]
    
    //Function which returns a random question and checks if the question has been asked before
    mutating func getRandomQuestion() -> Question? {
        var question: Question?
        
        var randomInt = createRandomInt()
        
        if questionIndicesUsed.isEmpty || !questionIndicesUsed.contains(randomInt) {
            questionIndex = randomInt
            questionIndicesUsed.append(randomInt)
            let randomQuestion = questions[randomInt]
            question = randomQuestion
        } else {
            for index in questionIndicesUsed {
                while randomInt == index {
                    randomInt = createRandomInt()
                    questionIndex = randomInt
                    questionIndicesUsed.append(randomInt)
                    let randomQuestion = questions[randomInt]
                    question = randomQuestion
                }
            }
        }
        
        return question
    }
    
    //Helper method to create a random integer
    func createRandomInt() -> Int {
        return GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
    }
    
    //Function which returns possible answers in regard of the current question index
    func getPossibleAnswersToRandomQuestion() -> [String] {
        return questions[questionIndex].possibleAnswers
    }
    
    //Function which returns the correct answer to the current question
    func getCorrectAnswerToQuestion() -> String {
        let question = questions[questionIndex]
        return question.answer
    }
}
