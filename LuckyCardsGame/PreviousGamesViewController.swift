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

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
