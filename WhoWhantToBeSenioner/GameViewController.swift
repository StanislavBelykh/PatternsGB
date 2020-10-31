//
//  GameViewController.swift
//  WhoWhantToBeSenioner
//
//  Created by Станислав Белых on 27.10.2020.
//

import UIKit

final class GameViewController: UIViewController {
    
    @IBOutlet private var numberQuestionLabel: UILabel!
    @IBOutlet private var questionLabel: UILabel!
    @IBOutlet private var answerButtons: [UIButton]!
    @IBOutlet private var pesentComplitionLabel: UILabel!
    
    var strategy: StrategyGame!
    
    private var questions = [Question]()
    private var question: Question?
    private var answers = [String]()
    
    private var countAnswer = Observable<Int>(0)
    private var countQuestions = 0
    
    weak var delegate: GameSessionDelegate?
    
    override func viewDidLoad() {
        questions = strategy.getQuestions()
        countAnswer.value = 0
        countQuestions = questions.count
        countAnswer.addObserver(self, options: [ .new, .initial ] ) { [weak self] (countAnswer, _) in
            guard let self = self else { return }
            self.pesentComplitionLabel.text = "Выполненно: \( Int( Float(countAnswer) / Float(self.countQuestions) * 100 ))%"
        }
        
        setQuestions()
    }
    
    @IBAction private func answerSelect(_ sender: UIButton) {
        guard let testButton = sender.titleLabel?.text else { return }
        if answers.contains(testButton) {
            
            countAnswer.value += 1
            if !questions.isEmpty {
                setQuestions()
            } else {
                delegate?.didEndGame(
                    allCountQuestion: countQuestions,
                    answerCount: countAnswer.value
                )
                print("finish")
                self.showResult(countTrueAnswer: countAnswer.value, countAllAnswers: countQuestions)
            }
        } else {
            delegate?.didEndGame(
                allCountQuestion: countQuestions,
                answerCount: countAnswer.value
            )
            self.showResult(countTrueAnswer: countAnswer.value, countAllAnswers: countQuestions)
        }
    }
    
    private func setQuestions() {
        question = questions.removeFirst()
        guard let question = question else { return }
        
        numberQuestionLabel.text = "Номер билета: \(question.id)"
        questionLabel.text = question.question
        
        let answers = Array(question.answers)
        answerButtons.enumerated().forEach { button in
            button.element.setTitle(answers[button.offset].key, for: .normal)
        }
        
        self.answers = answers
            .filter { $0.value == true }
            .map{ $0.key }
    }
    
    private func showResult(countTrueAnswer: Int, countAllAnswers: Int) {
        let alert = UIAlertController(
            title: "Результат",
            message: "Правильных ответов: \(countTrueAnswer) \n всего вопросов: \(countAllAnswers)",
            preferredStyle: .alert
        )
        let actions = UIAlertAction(
            title: "Okay",
            style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        alert.addAction(actions)
        
        present(alert, animated: true, completion: nil)
    }
}
 
protocol GameSessionDelegate: AnyObject {
    var gameSession: GameSession { get set }
    func didEndGame(allCountQuestion: Int, answerCount: Int)
}
