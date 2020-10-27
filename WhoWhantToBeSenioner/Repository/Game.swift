//
//  Game.swift
//  WhoWhantToBeSenioner
//
//  Created by Станислав Белых on 27.10.2020.
//

import Foundation

final class Game {
    
    static let shared = Game()
    
    var currentGame: GameSession?
    
    private(set) var games = [GameSession]()
    private let recorder = GameCaretaker()
    
    private init() {}
    
    func recordSession() {
        guard let game = currentGame else {
            return
        }
        games.append(game)
        do {
            try recorder.saveGame(game)
        } catch {
            print("Error record")
        }
        currentGame = GameSession()
        print(games)
    }
}

