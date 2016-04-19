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
    
    var questionIndex = Int()
    var questionIndicesUsed = [Int]()
    
    let questions = [
        ["question": "This was the only US President to serve more than two consecutive terms.", "answer": "Franklin D. Roosevelt"],
        ["question": "Which of the following countries has the most residents?", "answer": "Nigeria"],
        ["question": "In what year was the United Nations founded?", "answer": "1945"],
        ["question": "The Titanic departed from the United Kingdom, where was it supposed to arrive?", "answer": "New York City"],
        ["question": "Which nation produces the most oil?", "answer": "Canada"],
        ["question": "Which country has most recently won consecutive World Cups in Soccer?", "answer": "Brazil"],
        ["question": "Which of the following rivers is longest?", "answer": "Mississippi"],
        ["question": "Which city is the oldest?", "answer": "Mexico City"],
        ["question": "Which country was the first to allow women to vote in national elections?", "answer": "Poland"],
        ["question": "Which of these countries won the most medals in the 2012 Summer Games?", "answer": "Great Britain"]
    ]
    
    let answers = [
        ["George Washington", "Franklin D. Roosevelt", "Woodrow Wilson", "Andrew Jackson"],
        ["Nigeria", "Russia", "Iran", "Vietnam"],
        ["1918", "1919", "1945", "1954"],
        ["Paris", "Washington D.C.", "New York City", "Boston"],
        ["Iran", "Iraq", "Brazil", "Canada"],
        ["Italy", "Brazil", "Argentina", "Spain"],
        ["Yangtze", "Mississippi", "Congo", "Mekong"],
        ["Mexico City", "Cape Town", "San Juan", "Sydney"],
        ["Poland", "United States", "Sweden", "Senegal"],
        ["France", "Germany", "Great Britain"]
    ]
    
    mutating func getRandomQuestion() -> [String: String]? {
        var randomInt = createRandomInt()
        
        if !questionHasBeenAskedBefore(randomInt) {
            
            return questionFromIndex(randomInt)
        } else {
            randomInt = createRandomInt()

            return questionFromIndex(randomInt)
        }
    }
    
    mutating func questionFromIndex(index: Int) -> [String: String] {
        self.questionIndex = index
        self.questionIndicesUsed.append(index)
        
        return questions[index]
    }
    
    func questionHasBeenAskedBefore(question: Int) -> Bool {
        var hasBeenAsked = Bool()
        
        for index in questionIndicesUsed {
            hasBeenAsked = index == question
        }
        
        return hasBeenAsked
    }
    
    func createRandomInt() -> Int {
        return GKRandomSource.sharedRandom().nextIntWithUpperBound(questions.count)
    }
    
    func getPossibleAnswersToRandomQuestion() -> [String] {
        return answers[questionIndex]
    }
    
    func getCorrectAnswerToQuestion() -> String {
        let question = questions[questionIndex]
        let answer = question["answer"]
        return answer!
    }
}