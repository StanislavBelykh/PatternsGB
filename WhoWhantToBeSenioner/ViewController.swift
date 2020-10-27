//
//  ViewController.swift
//  WhoWhantToBeSenioner
//
//  Created by Станислав Белых on 27.10.2020.
//

import UIKit

class ViewController: UIViewController {

    private let gameSession = GameSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "segue":
            guard let destination = segue.destination as? GameViewController else { return }
            destination.delegate = self
        default:
            break
        }
    }

    @IBAction func gameButtonPressed(_ sender: Any) {
        Game.shared.currentGame = gameSession
    }
}

extension ViewController: GameSessionDelegate {
    func didEndGame(allCountQuestion: Int, answerCount: Int) {
        gameSession.countAnswers = answerCount
        gameSession.countQuestion = allCountQuestion
        
        Game.shared.recordSession()
    }
}
