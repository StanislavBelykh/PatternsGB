//
//  GameSession.swift
//  WhoWhantToBeSenioner
//
//  Created by Станислав Белых on 27.10.2020.
//

import Foundation

class GameSession: Codable {
    var countQuestion: Int
    var countAnswers: Int
    
    private var rang: Rang {
        switch Double(countAnswers)/Double(countQuestion) {
        case 0..<0.25:
            return .intern
        case 0.26..<0.5:
            return .junior
        case 0.5..<0.75:
            return .middle
        case 0.75...1:
            return .senior
        default:
            return .unknow
        }
    }
    
    init(countQuestion: Int, countAnswers: Int) {
        self.countQuestion = countQuestion
        self.countAnswers = countAnswers
    }
    
    convenience init() {
        self.init(countQuestion: 0, countAnswers: 0)
    }
}

enum Rang {
    case intern
    case junior
    case middle
    case senior
    case unknow
}
