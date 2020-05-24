
import UIKit

class GameOverViewController: UIViewController {
     @IBOutlet weak var gameOver_LBL_resultOfTime: UILabel!
    
    var fromMode : Int?
    var time : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        gameOver_LBL_resultOfTime.text = "\(time!)s"
    }
    

    @IBAction func onClickRestart(_ sender: Any) {
        self.performSegue(withIdentifier: "goToGame", sender: self)
        

    }
    @IBAction func onClickMenu(_ sender: Any) {
        self.performSegue(withIdentifier: "goToMenu", sender: self)

    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToGame"){
            let gameView = segue.destination as! GameController
            gameView.numberOfRows = fromMode
            gameView.numberOfCols = 4
             
        }

    }
    
    

}
