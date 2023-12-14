//
//  ViewController.swift
//  LuckyCardsGame
//
//  Created by STANISLAV STAJILA on 12/5/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = UserDefaults.standard.data(forKey: "Scores") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([GameScores].self, from: items) {
                Delegate.gameScores = decoded
            }
        }
    }

    @IBAction func getStarted(_ sender: Any) {
        performSegue(withIdentifier: "game", sender: self)
    }
    
    @IBAction func previousGames(_ sender: Any) {
        performSegue(withIdentifier: "previousGames", sender: self)
    }
}

