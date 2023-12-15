//
//  TieViewController.swift
//  LuckyCardsGame
//
//  Created by STANISLAV STAJILA on 12/14/23.
//

import UIKit

class TieViewController: UIViewController {

    var delegate: ViewControllerDelegate!
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
    
    var UImage2: UIImage?
    var CImage2: UIImage?
    var UImage3: UIImage?
    var CImage3: UIImage?
    var UImage4: UIImage?
    var CImage4: UIImage?
    var tieCase = UIAlertController(title: "Its a Tie", message: "Both cards get dismissed from both decks!", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        var okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        tieCase.addAction(okAction)
        
            U1.image = UIImage(named: convertNametoImageId(card: Delegate.userDeck[0]))
            C1.image = UIImage(named: convertNametoImageId(card: Delegate.computerDeck[0]))
            U5.image = UIImage(named: convertNametoImageId(card: Delegate.userDeck[4]))
            C5.image = UIImage(named: convertNametoImageId(card: Delegate.computerDeck[4]))
        
        
        if let image = UIImage(named: convertNametoImageId(card: Delegate.userDeck[1])){
            UImage2 = image
        }
        
        
        if let image = UIImage(named: convertNametoImageId(card: Delegate.computerDeck[1])){
            CImage2 = image
        }
        
        
        if let image = UIImage(named: convertNametoImageId(card: Delegate.userDeck[2])){
            UImage3 = image
        }
        
        if let image = UIImage(named: convertNametoImageId(card: Delegate.computerDeck[2])){
            CImage3 = image
        }
        
        if let image = UIImage(named: convertNametoImageId(card: Delegate.userDeck[3])){
            UImage4 = image
        }
        
        if let image = UIImage(named: convertNametoImageId(card: Delegate.computerDeck[3])){
            CImage4 = image
        }
       
            
            if Delegate.userDeck[4].value > Delegate.computerDeck[4].value{
                Delegate.userDeck.append(Delegate.userDeck.remove(at: 0))
                Delegate.userDeck.append(Delegate.userDeck.remove(at: 0))
                Delegate.userDeck.append(Delegate.userDeck.remove(at: 0))
                Delegate.userDeck.append(Delegate.userDeck.remove(at: 0))
                Delegate.userDeck.append(Delegate.userDeck.remove(at: 0))
                Delegate.userDeck.append(Delegate.computerDeck.remove(at: 0))
                Delegate.userDeck.append(Delegate.computerDeck.remove(at: 0))
                Delegate.userDeck.append(Delegate.computerDeck.remove(at: 0))
                Delegate.userDeck.append(Delegate.computerDeck.remove(at: 0))
                Delegate.userDeck.append(Delegate.computerDeck.remove(at: 0))
                Delegate.userPoints += 1
                Delegate.TPoints += 1
                
                print ("\(Delegate.userDeck.count)  \(Delegate.computerDeck.count)")
                print ("at the end \(Delegate.userDeck[Delegate.userDeck.count-1].value) one before \(Delegate.userDeck[Delegate.userDeck.count-2].value)")
                
            } else if Delegate.computerDeck[4].value > Delegate.userDeck[4].value{
                Delegate.computerDeck.append(Delegate.computerDeck.remove(at: 0))
                Delegate.computerDeck.append(Delegate.computerDeck.remove(at: 0))
                Delegate.computerDeck.append(Delegate.computerDeck.remove(at: 0))
                Delegate.computerDeck.append(Delegate.computerDeck.remove(at: 0))
                Delegate.computerDeck.append(Delegate.computerDeck.remove(at: 0))
                Delegate.computerDeck.append(Delegate.userDeck.remove(at: 0))
                Delegate.computerDeck.append(Delegate.userDeck.remove(at: 0))
                Delegate.computerDeck.append(Delegate.userDeck.remove(at: 0))
                Delegate.computerDeck.append(Delegate.userDeck.remove(at: 0))
                Delegate.computerDeck.append(Delegate.userDeck.remove(at: 0))
                Delegate.computerPoints += 1
                Delegate.TPoints += 1
                
                print ("\(Delegate.userDeck.count)  \(Delegate.computerDeck.count)")
                
            } else{
                
                Delegate.computerDeck.remove(at: 0)
                Delegate.userDeck.remove(at: 0)
                Delegate.userPoints += 1
                Delegate.computerPoints += 1
                Delegate.TPoints += 1
                
                present(tieCase, animated: true)
                
            }
        
        
        delegate.updateScoreLabel()
        delegate.updateUAmountLabel()
        delegate.updateCAmountLabel()
            
        }
        
    
    
    
    @IBAction func showCards(_ sender: Any) {
        U2.image = UImage2
        C2.image = CImage2
        U3.image = UImage3
        C3.image = CImage3
        U4.image = UImage4
        C4.image = CImage4
    }
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true)
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
