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
        // Do any additional setup after loading the view.
    }

    @IBAction func getStarted(_ sender: Any) {
        performSegue(withIdentifier: "game", sender: self)
    }
    
}

