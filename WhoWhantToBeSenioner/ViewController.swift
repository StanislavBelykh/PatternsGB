//
//  ViewController.swift
//  WhoWhantToBeSenioner
//
//  Created by Станислав Белых on 27.10.2020.
//

import UIKit

final class ViewController: UIViewController {

    var gameSession = GameSession()
    private var isShowSettings = false
    private let caretracerQuestion = QuestionsCaretaker()
    
    @IBOutlet private var mineView: UIView!
    @IBOutlet private var changeStyleGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAppearance()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "segue":
            guard let destination = segue.destination as? GameViewController else { return }
            destination.delegate = self
            let questions = caretracerQuestion.loadQuestions().getQuestions()
            destination.strategy = Game.shared.sequenceIsShuffle ? StrategyGameMediumImpl(questions) : StrategyGameEasyImpl(questions)
        default:
            break
        }
    }

    @IBAction private func gameButtonPressed(_ sender: Any) {
        Game.shared.currentGame = gameSession
    }
    
    @IBAction private func showSettings(_ sender: Any) {

        if isShowSettings {
            UIView.animate(withDuration: 0.3) {
                self.mineView.transform = .identity
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                let translation = CGAffineTransform(translationX: -70, y: -70)
                self.mineView.transform = translation
            }
        }
        isShowSettings.toggle()
        
    }
    
    @IBAction private func changeStyleGame(_ sender: Any) {
        
        if Game.shared.sequenceIsShuffle {
            changeStyleGameButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        } else {
            changeStyleGameButton.setImage(UIImage(systemName: "shuffle"), for: .normal)
        }
        
        Game.shared.sequenceIsShuffle.toggle()
    }
    @IBAction func addQuestion(_ sender: Any) {
        showAlertAddQuestion()
        UIView.animate(withDuration: 0.3) {
            self.mineView.transform = .identity
        }
        isShowSettings = false
    }
    
    private func setViewAppearance() {
        mineView.layer.cornerRadius = 10
        mineView.layer.shadowColor = UIColor.blue.cgColor
        mineView.layer.shadowRadius = 5
        mineView.layer.shadowOpacity = 0.5
        changeStyleGameButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
    }
    
    private func showAlertAddQuestion() {
        let alert = UIAlertController(
            title: "Добавить вопрос",
            message: "Напишите ваш вопрос и ответы к вопросу. \nВсе поля должны быть уникальны.",
            preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Вопрос"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Правильный ответ"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Неправильный ответ"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Неправильный ответ"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Неправильный ответ"
        }
        
        let add = UIAlertAction(
            title: "Добавить",
            style: .default) { (_) in
            
            let question = Question(
                id: 0,
                question: alert.textFields?[0].text ?? "",
                answers: [
                    "\(alert.textFields?[1].text ?? "") " : true,
                    "\(alert.textFields?[2].text ?? "")  " : false,
                    "\(alert.textFields?[3].text ?? "")   " : false,
                    "\(alert.textFields?[4].text ?? "")    " : false
                ]
            )
            try? self.caretracerQuestion.saveQuestion(question)
        }
        add.isEnabled = false
        
        let cancel = UIAlertAction(
            title: "Отмена",
            style: .cancel)
        
        alert.addAction(add)
        alert.addAction(cancel)
        
        for i in 0...4 {
            NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: alert.textFields?[i],
                queue: OperationQueue.main
            ) { (notification) -> Void in
                
                let textFields = alert.textFields?.compactMap { $0.text }
                guard let texts = textFields else {
                    add.isEnabled = false
                    return
                }
                
                if Set(texts).count == 5, !texts.contains("") {
                    add.isEnabled = true
                } else {
                    add.isEnabled = false
                }
            }
        }
        
        self.present(alert, animated: true)
    }
}

extension ViewController: GameSessionDelegate {
    func didEndGame(allCountQuestion: Int, answerCount: Int) {
        gameSession.countAnswers = answerCount
        gameSession.countQuestion = allCountQuestion
        
        Game.shared.recordSession()
    }
}
