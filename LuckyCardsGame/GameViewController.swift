//
//  GameViewController.swift
//  LuckyCardsGame
//
//  Created by STANISLAV STAJILA on 12/5/23.
//

import UIKit

public class Deck{
    var value: Int
    var suit: String
    
    init (value: Int, suit: String){
        self.value = value
        self.suit = suit
    }
}


class GameViewController: UIViewController {

    @IBOutlet weak var playerImageView: UIImageView!
    
    @IBOutlet weak var computerImageView: UIImageView!
    
    var deck: [Deck] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1..<14 {
            deck.append(Deck(value: i+1, suit: "spades"))
            deck.append(Deck(value: i+1, suit: "hearts"))
            deck.append(Deck(value: i+1, suit: "diamonds"))
            deck.append(Deck(value: i+1, suit: "clubs"))
        }
        
        for val in deck{
            print("\(val.value) " + val.suit)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
