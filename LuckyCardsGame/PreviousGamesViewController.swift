//
//  PreviousGamesViewController.swift
//  LuckyCardsGame
//
//  Created by STANISLAV STAJILA on 12/12/23.
//

import UIKit

class PreviousGamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Delegate.gameScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! CustomCell
        cell.scoreOutlet.text = Delegate.gameScores[indexPath.row].score
        cell.userScoredOutlet.text = "\(Delegate.gameScores[indexPath.row].userPoints)"
        cell.computerScoredOutlet.text = "\(Delegate.gameScores[indexPath.row].computerPoints)"
        cell.tieScoreOutlet.text = "\(Delegate.gameScores[indexPath.row].tiedPoints)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == .delete{
            
            Delegate.gameScores.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(Delegate.gameScores) {
                               UserDefaults.standard.set(encoded, forKey: "Scores")
                           }
            
            tableView.reloadData()
        }
    }
    

    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
