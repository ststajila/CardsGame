/*Programming Concepts:
1. Operators
2. if/else statements
3. While loop
4. Arrays
5. Functions
6. Classes
7. Switch
8. Persistance
9. Protocols
10. If let statements
11. App Icon
*/
/*UI Elements:
1. Button
2. Label
3. Image View
4. View Controller
5. Alert Controller
6. Stack View
7. Table View
8. Navigation Bar
9. Navigation Controller
 */


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

