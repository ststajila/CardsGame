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
    static var defaults = UserDefaults.standard
    static var userPoints = 0
    static var computerPoints = 0
    static var deck: [Card] = []
    static var userDeck: [Card] = []
    static var computerDeck: [Card] = []
    static var UPoints: Int = 0
    static var CPoints: Int = 0
    static var TPoints: Int = 0
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
    
    @IBOutlet weak var playerImageView: UIImageView!
    
    @IBOutlet weak var computerImageView: UIImageView!
    
    @IBOutlet weak var UAmountOutlet: UILabel!
    
    @IBOutlet weak var CAmountOutlet: UILabel!
    
    var gameOver = UIAlertController(title: "GameOver", message: "You won", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGame()
        
        countLabel.text = "\(Delegate.userPoints) - \(Delegate.computerPoints)"
        UAmountOutlet.text = "Amount of Cards in the Deck: \(Delegate.userDeck.count)"
        CAmountOutlet.text = "Amount of Cards in the Deck: \(Delegate.computerDeck.count)"
        
        
        let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: { go in
            self.newGame()
            self.countLabel.text = "\(Delegate.userPoints) - \(Delegate.computerPoints)"
            self.UAmountOutlet.text = "Amount of Cards in the Deck: \(Delegate.userDeck.count)"
            self.CAmountOutlet.text = "Amount of Cards in the Deck: \(Delegate.computerDeck.count)"
            
            
            self.performSegue(withIdentifier: "detail", sender: self)
            })
           
            gameOver.addAction(okAction)
        
        
    }
    
    @IBAction func play(_ sender: Any) {
        if Delegate.userDeck.count != 0 && Delegate.computerDeck.count != 0{
            playerImageView.image = UIImage(named: convertNametoImageId(card: Delegate.userDeck[0]))
            computerImageView.image = UIImage(named: convertNametoImageId(card: Delegate.computerDeck[0]))
            
            if Delegate.userDeck[0].value > Delegate.computerDeck[0].value{
                Delegate.userDeck.append(Delegate.userDeck.remove(at: 0))
                var temp = Delegate.computerDeck.remove(at: 0)
                Delegate.userDeck.append(temp)
                Delegate.userPoints += 1
                Delegate.UPoints += 1
                countLabel.text = "\(Delegate.userPoints) - \(Delegate.computerPoints)"
                UAmountOutlet.text = "Amount of Cards in the Deck: \(Delegate.userDeck.count)"
                CAmountOutlet.text = "Amount of Cards in the Deck: \(Delegate.computerDeck.count)"
            } else if Delegate.computerDeck[0].value > Delegate.userDeck[0].value{
                Delegate.computerDeck.append(Delegate.computerDeck.remove(at: 0))
                var temp = Delegate.userDeck.remove(at: 0)
                Delegate.computerDeck.append(temp)
                Delegate.computerPoints += 1
                Delegate.CPoints += 1
                countLabel.text = "\(Delegate.userPoints) - \(Delegate.computerPoints)"
                UAmountOutlet.text = "Amount of Cards in the Deck: \(Delegate.userDeck.count)"
                CAmountOutlet.text = "Amount of Cards in the Deck: \(Delegate.computerDeck.count)"
            } else{

                performSegue(withIdentifier: "tie", sender: self)
                
//                Delegate.computerDeck.remove(at: 0)
//                Delegate.userDeck.remove(at: 0)
//                
//                Delegate.userPoints += 1
//                Delegate.computerPoints += 1
//                Delegate.TPoints += 1
//                countLabel.text = "\(Delegate.userPoints) - \(Delegate.computerPoints)"
//                UAmountOutlet.text = "Amount of Cards in the Deck: \(Delegate.userDeck.count)"
//                CAmountOutlet.text = "Amount of Cards in the Deck: \(Delegate.computerDeck.count)"
            }
            
            
        } else{
            if Delegate.userPoints > Delegate.computerPoints{
                gameOver.message = "Congratulations, you have won the game"
            }else if Delegate.computerPoints > Delegate.userPoints{
                gameOver.message = "Unfortunately, you lost the game"
            }else{
                gameOver.message = "it's a draw"
            }
            
            Delegate.gameScores.append(GameScores(score: "\(Delegate.userPoints) - \(Delegate.computerPoints)", userPoints: Delegate.UPoints, computerPoints: Delegate.CPoints, tiedPoints: Delegate.TPoints))
            
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
                switch card.value {
                case 11:
                    return "jack_of_\(card.suit)2.png"
                case 12:
                    return "queen_of_\(card.suit)2.png"
                case 13:
                    return "king_of_\(card.suit)2.png"
                case 14:
                    return "ace_of_\(card.suit).png"
                default:
                    return "black_joker"
                }
            }
        }
    
    func newGame() -> Bool{
        Delegate.deck = []
        Delegate.userDeck = []
        Delegate.computerDeck = []
        
        Delegate.deck = populateTheDeck()
        Delegate.deck.shuffle()
        
        for i in 0..<26{
            Delegate.userDeck.append(Delegate.deck[i])
        }
        for i in 26..<52{
            Delegate.computerDeck.append(Delegate.deck[i])
        }
        Delegate.userPoints = 0
        Delegate.computerPoints = 0
        Delegate.UPoints = 0
        Delegate.CPoints = 0
        Delegate.TPoints = 0
        return true
    }
        
    }
