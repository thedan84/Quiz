//
//  QuizModel.swift
//  TrueFalseStarter
//
//  Created by Dennis Parussini on 17-04-16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

struct Question: Equatable {
    var question: String
    var answer: String
    var possibleAnswers: [String]
}
