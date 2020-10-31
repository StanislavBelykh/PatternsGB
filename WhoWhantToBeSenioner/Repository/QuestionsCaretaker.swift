//
//  QuestionsCaretaker.swift
//  WhoWhantToBeSenioner
//
//  Created by Станислав Белых on 31.10.2020.
//

import Foundation

class QuestionsCaretaker {
    typealias Memento = Data
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let key = "questions"
    
    lazy var questions: Questions = {
        return loadQuestions()
    }()
    
    func saveQuestion(_ question: Question) throws {
        let id = questions.questions.count + questions.userQuestions.count
        let newQuestion = (Question(id: id, question: question.question, answers: question.answers))
        questions.userQuestions.append(newQuestion)
        let data: Memento = try encoder.encode(questions.userQuestions)
        UserDefaults.standard.set(data, forKey: key)
        print("saved")
    }
    
    func loadQuestions() -> Questions {
        guard
            let data = UserDefaults.standard.value(forKey: key) as? Memento,
            let userQuestions = try? decoder.decode([Question].self, from: data)
        else {
            return Questions()
        }
        
        var questions = Questions()
        questions.userQuestions = userQuestions
        
        return questions
    }
    
}
