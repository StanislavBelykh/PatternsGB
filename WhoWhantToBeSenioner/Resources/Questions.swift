//
//  Questions.swift
//  WhoWhantToBeSenioner
//
//  Created by Станислав Белых on 27.10.2020.
//

import Foundation

struct Questions: Codable {
    var userQuestions = [Question]()
    var questions: [Question] = [
        Question.init(
            id: 0,
            question: "Какого типа паттерна НЕ существует",
            answers: [
                "Поведенческие": false,
                "Порождающие": false,
                "Структурные": false,
                "Наблюдательные": true
            ]),
        Question.init(
            id: 1,
            question: "Паттерн позволяющий объектам с несовместимым интерфейсом работать вместе",
            answers: [
                "Facade": false,
                "Memento": false,
                "Delegate": false,
                "Adapter": true
            ]),
        Question.init(
            id: 2,
            question: "Паттерн предназначенный для распространения сообщений / событий между разными объектами",
            answers: [
                "Strategy": false,
                "Delegate": false,
                "Adapter": false,
                "Observer": true
            ]),
        Question.init(
            id: 3,
            question: "Описание паттерна: Один объект для выполнения определенных действий передает управление другому объекту",
            answers: [
                "Closure": false,
                "Memento": false,
                "Singlton": false,
                "Delegate": true
            ]),
        Question.init(
            id: 4,
            question: "Чем можно заменить паттерн Delegate",
            answers: [
                "Segue": false,
                "Наследование": false,
                "Singlton": false,
                "Closure": true
            ]),
        Question.init(
            id: 5,
            question: "Этот паттерн используется для того, чтобы при работе с объектом была возможность его сохранить и впоследствии восстановить.",
            answers: [
                "Strategy": false,
                "Delegate": false,
                "Singlton": false,
                "Memento": true
            ]),
        Question.init(
            id: 6,
            question: "Этот паттерн упрощает сложную систему, предоставляя простой интерфейс",
            answers: [
                "Adapter": false,
                "Singlton": false,
                "Strategy": false,
                "Facade": true
            ]),
        Question.init(
            id: 7,
            question: "Что означает буква М в абриввиатуре MVC",
            answers: [
                "Multi": false,
                "Mass": false,
                "Massive": false,
                "Model": true
            ]),
        Question.init(
            id: 8,
            question: "Этот паттерн применяется, когда сложный процесс создания объекта можно разбить на шаги, чтобы упростить",
            answers: [
                "Delegate": false,
                "Singlton": false,
                "Facade": false,
                "Builder": true
            ]),
        Question.init(
            id: 9,
            question: "Какая архитектура лучшая?",
            answers: [
                "MVVM": true,
                "Clean Swift": true,
                "VIPER": true,
                "MVC": true
            ]),
    ]
    
    func getQuestions() -> [Question] {
        return questions + userQuestions
    }
}

struct Question: Codable {
    let id: Int
    let question: String
    let answers: [String: Bool]
}
