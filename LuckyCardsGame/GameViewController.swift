//
//  GameViewController.swift
//  LuckyCardsGame
//
//  Created by STANISLAV STAJILA on 12/5/23.
//

import UIKit

class GameScores: Codable{
    var score: String
    var userPoints: Int
    var computerPoints: Int
    var tiedPoints: Int
    
    init(score: String, userPoints: Int, computerPoints: Int, tiedPoints: Int){
        self.score = score
        self.userPoints = userPoints
        self.computerPoints = computerPoints
        self.tiedPoints = tiedPoints
    }
}


class Delegate{
    static var gameScores: [GameScores] = []
    var defaults = UserDefaults.standard
}

class Card{
    var value: Int
    var suit: String
    
    init (value: Int, suit: String){
        self.value = value
        self.suit = suit
    }
}


class GameViewController: UIViewController {
    
    
    @IBOutlet weak var countLabel: UILabel!
    
    var userPoints = 0
    var computerPoints = 0
    
    @IBOutlet weak var playerImageView: UIImageView!
    
    @IBOutlet weak var computerImageView: UIImageView!
    
    var deck: [Card] = []
    var userDeck: [Card] = []
    var computerDeck: [Card] = []
    var gameOver = UIAlertController(title: "GameOver", message: "You won", preferredStyle: .alert)
    
    var UPoints: Int = 0
    var CPoints: Int = 0
    var TPoints: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = UserDefaults.standard.data(forKey: "Scores") {
                        let decoder = JSONDecoder()
                        if let decoded = try? decoder.decode([GameScores].self, from: items) {
                            Delegate.gameScores = decoded
                        }
                }
        
        countLabel.text = "\(userPoints) - \(computerPoints)"
        
        deck = populateTheDeck()
        deck.shuffle()
        
        for i in 0..<26{
            userDeck.append(deck[i])
        }
        for i in 26..<52{
            computerDeck.append(deck[i])
        }
        
        
        let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: { go in
            
            self.deck = []
            self.userDeck = []
            self.computerDeck = []
            
            self.deck = self.populateTheDeck()
            self.deck.shuffle()
            
            for i in 0..<26{
                self.userDeck.append(self.deck[i])
            }
            for i in 26..<52{
                self.computerDeck.append(self.deck[i])
            }
            
            self.userPoints = 0
            self.computerPoints = 0
            self.UPoints = 0
            self.CPoints = 0
            self.TPoints = 0
            
            self.countLabel.text = "\(self.userPoints) - \(self.computerPoints)"
            
            
            self.performSegue(withIdentifier: "detail", sender: self)
            })
           
            gameOver.addAction(okAction)
        
        
    }
    
    @IBAction func play(_ sender: Any) {
        if userDeck.count != 0 && computerDeck.count != 0{
            playerImageView.image = UIImage(named: convertNametoImageId(card: userDeck[0]))
            computerImageView.image = UIImage(named: convertNametoImageId(card: computerDeck[0]))
            
            if userDeck[0].value > computerDeck[0].value{
                userDeck.append(userDeck.remove(at: 0))
                var temp = computerDeck.remove(at: 0)
                userDeck.append(temp)
                userPoints += 1
                UPoints += 1
                countLabel.text = "\(userPoints) - \(computerPoints)"
            } else if computerDeck[0].value > userDeck[0].value{
                computerDeck.append(computerDeck.remove(at: 0))
                var temp = userDeck.remove(at: 0)
                computerDeck.append(temp)
                computerPoints += 1
                CPoints += 1
                countLabel.text = "\(userPoints) - \(computerPoints)"
            } else{
                computerDeck.remove(at: 0)
                userDeck.remove(at: 0)
                
                userPoints += 1
                computerPoints += 1
                TPoints += 1
                countLabel.text = "\(userPoints) - \(computerPoints)"
            }
            
            
        } else{
            if userPoints > computerPoints{
                gameOver.message = "Congratulations, you have won the game"
            }else if computerPoints > userPoints{
                gameOver.message = "Unfortunately, you lost the game"
            }else{
                gameOver.message = "it's a draw"
            }
            
            Delegate.gameScores.append(GameScores(score: "\(userPoints) - \(computerPoints)", userPoints: UPoints, computerPoints: CPoints, tiedPoints: TPoints))
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(Delegate.gameScores) {
                               UserDefaults.standard.set(encoded, forKey: "Scores")
                           }
            
            present(gameOver, animated: true)
            print("Game Over")
        }
    }
    
        
    func populateTheDeck() -> [Card]{
            var deckOfCards: [Card] = []
            for i in 1..<14 {
                deckOfCards.append(Card(value: i+1, suit: "spades"))
                deckOfCards.append(Card(value: i+1, suit: "hearts"))
                deckOfCards.append(Card(value: i+1, suit: "diamonds"))
                deckOfCards.append(Card(value: i+1, suit: "clubs"))
            }
            return deckOfCards
        }
        
        
    func convertNametoImageId(card: Card) -> String{
            if card.value < 11{
                return "\(card.value)_of_\(card.suit).png"
            }else{
                if card.value == 11{
                    return "jack_of_\(card.suit)2.png"
                } else if card.value == 12{
                    return "queen_of_\(card.suit)2.png"
                } else if card.value == 13{
                    return "king_of_\(card.suit)2.png"
                } else{
                    return "ace_of_\(card.suit).png"
                }
            }
        }
        
    }
