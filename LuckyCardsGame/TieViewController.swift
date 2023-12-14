//
//  TieViewController.swift
//  LuckyCardsGame
//
//  Created by STANISLAV STAJILA on 12/14/23.
//

import UIKit

class TieViewController: UIViewController {

    @IBOutlet weak var U1: UIImageView!
    @IBOutlet weak var U2: UIImageView!
    @IBOutlet weak var U3: UIImageView!
    @IBOutlet weak var U4: UIImageView!
    @IBOutlet weak var U5: UIImageView!
    
    @IBOutlet weak var C1: UIImageView!
    @IBOutlet weak var C2: UIImageView!
    @IBOutlet weak var C3: UIImageView!
    @IBOutlet weak var C4: UIImageView!
    @IBOutlet weak var C5: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Delegate.userDeck.count >= 5 && Delegate.computerDeck.count >= 5{
            
            U1.image = UIImage(named: convertNametoImageId(card: Delegate.userDeck[0]))
            C1.image = UIImage(named: convertNametoImageId(card: Delegate.computerDeck[0]))
            U5.image = UIImage(named: convertNametoImageId(card: Delegate.userDeck[4]))
            C5.image = UIImage(named: convertNametoImageId(card: Delegate.computerDeck[4]))
            
            if Delegate.userDeck[4].value > Delegate.computerDeck[4].value{
                Delegate.userDeck.append(Delegate.userDeck.remove(at: 0))
                Delegate.userDeck.append(Delegate.userDeck.remove(at: 1))
                Delegate.userDeck.append(Delegate.userDeck.remove(at: 2))
                Delegate.userDeck.append(Delegate.userDeck.remove(at: 3))
                Delegate.userDeck.append(Delegate.userDeck.remove(at: 4))
                Delegate.userDeck.append(Delegate.computerDeck.remove(at: 0))
                Delegate.userDeck.append(Delegate.computerDeck.remove(at: 1))
                Delegate.userDeck.append(Delegate.computerDeck.remove(at: 2))
                Delegate.userDeck.append(Delegate.computerDeck.remove(at: 3))
                Delegate.userDeck.append(Delegate.computerDeck.remove(at: 4))
                Delegate.userPoints += 1
                Delegate.TPoints += 1
            } else if Delegate.userDeck[4].value < Delegate.computerDeck[4].value{
                Delegate.computerDeck.append(Delegate.computerDeck.remove(at: 0))
                Delegate.computerDeck.append(Delegate.computerDeck.remove(at: 1))
                Delegate.computerDeck.append(Delegate.computerDeck.remove(at: 2))
                Delegate.computerDeck.append(Delegate.computerDeck.remove(at: 3))
                Delegate.computerDeck.append(Delegate.computerDeck.remove(at: 4))
                Delegate.computerDeck.append(Delegate.userDeck.remove(at: 0))
                Delegate.computerDeck.append(Delegate.userDeck.remove(at: 1))
                Delegate.computerDeck.append(Delegate.userDeck.remove(at: 2))
                Delegate.computerDeck.append(Delegate.userDeck.remove(at: 3))
                Delegate.computerDeck.append(Delegate.userDeck.remove(at: 4))
                Delegate.computerPoints += 1
                Delegate.TPoints += 1
            } else{
                Delegate.computerDeck.remove(at: 0)
                Delegate.userDeck.remove(at: 0)
                Delegate.userPoints += 1
                Delegate.computerPoints += 1
                Delegate.TPoints += 1
            }
            
            } else{
            Delegate.computerDeck.remove(at: 0)
            Delegate.userDeck.remove(at: 0)
            Delegate.userPoints += 1
            Delegate.computerPoints += 1
            Delegate.TPoints += 1
            self.dismiss(animated: true)
        }
        
    }
    
    
    
    @IBAction func showCards(_ sender: Any) {
        U2.image = UIImage(named: convertNametoImageId(card: Delegate.userDeck[1]))
        C2.image = UIImage(named: convertNametoImageId(card: Delegate.computerDeck[1]))
        U3.image = UIImage(named: convertNametoImageId(card: Delegate.userDeck[2]))
        C3.image = UIImage(named: convertNametoImageId(card: Delegate.computerDeck[2]))
        U4.image = UIImage(named: convertNametoImageId(card: Delegate.userDeck[3]))
        C4.image = UIImage(named: convertNametoImageId(card: Delegate.computerDeck[3]))
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
