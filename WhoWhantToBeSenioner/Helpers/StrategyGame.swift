//
//  StrategyGame.swift
//  WhoWhantToBeSenioner
//
//  Created by Станислав Белых on 31.10.2020.
//

import Foundation

protocol StrategyGame {
    func getQuestions() -> [Question]
}

class StrategyGameEasyImpl: StrategyGame {
    private let questions: [Question]
    
    init(_ questions: [Question]) {
        self.questions = questions
    }
    
    func getQuestions() -> [Question] {
        return questions
    }
}

class StrategyGameMediumImpl: StrategyGame {
    private let questions: [Question]
    
    init(_ questions: [Question]) {
        self.questions = questions
    }
    
    func getQuestions() -> [Question] {
        return questions.shuffled()
    }
}
