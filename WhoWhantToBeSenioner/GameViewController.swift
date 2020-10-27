//
//  GameViewController.swift
//  WhoWhantToBeSenioner
//
//  Created by Станислав Белых on 27.10.2020.
//

import UIKit

final class GameViewController: UIViewController {
    
    @IBOutlet private var questionLabel: UILabel!
    @IBOutlet private var firstButton: UIButton!
    @IBOutlet private var secondButton: UIButton!
    @IBOutlet private var thirdButton: UIButton!
    @IBOutlet private var fourthButton: UIButton!
    
    private var questions = Questions()
    private var question: Question?
    private var answers = [String]()
    
    private var countTrueAnswer = 0
    private var countQuestion: Int?
    
    weak var delegate: GameSessionDelegate?
    
    override func viewDidLoad() {
        countQuestion = questions.questions.count
        setQuestions()
    }
    
    @IBAction private func answerSelect(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        guard let testButton = button.titleLabel?.text else { return }
        if answers.contains(testButton) {
            
            countTrueAnswer += 1
            if !questions.questions.isEmpty {
                setQuestions()
            } else {
                delegate?.didEndGame(
                    allCountQuestion: countQuestion ?? 0,
                    answerCount: countTrueAnswer
                )
                print("finish")
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            delegate?.didEndGame(
                allCountQuestion: countQuestion ?? 0,
                answerCount: countTrueAnswer
            )
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setQuestions() {
        question = questions.questions.removeFirst()
        guard let question = question else { return }
        
        questionLabel.text = question.question
        
        let answers = Array(question.answers)
        firstButton.setTitle(answers[0].key, for: .normal)
        secondButton.setTitle(answers[1].key, for: .normal)
        thirdButton.setTitle(answers[2].key, for: .normal)
        fourthButton.setTitle(answers[3].key, for: .normal)
        
        self.answers = answers
            .filter { $0.value == true }
            .map{ $0.key }
    }
}
 
protocol GameSessionDelegate: AnyObject {
    func didEndGame(allCountQuestion: Int, answerCount: Int)
}
