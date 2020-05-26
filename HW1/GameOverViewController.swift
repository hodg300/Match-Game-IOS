
import UIKit

class GameOverViewController: UIViewController {
     @IBOutlet weak var gameOver_LBL_resultOfTime: UILabel!
    @IBOutlet weak var gameOver_EDT_name: UITextField!
    @IBOutlet weak var gameOver_VIEW_popUp: UIView!
    
    
    var fromMode : Int?
    var time : String?
    var location : MyLocation?
    var player : MyPlayer?
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
    
    @IBAction func gameOver_BTN_save(_ sender: Any) {
        print("\(String(describing: self.location?.lat)) , \(String(describing: self.location?.lng))")
        player = MyPlayer(gameOver_EDT_name.text ?? "PLAYER",Date(),self.location!.lat!,self.location!.lng!,String(gameOver_LBL_resultOfTime.text!))
        player?.printIt()
        //use in userDefault to save player details inside iphone
        gameOver_VIEW_popUp.isHidden = true
        view.endEditing(true)
    }
    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToGame"){
            let gameView = segue.destination as! GameController
            gameView.numberOfRows = fromMode
            gameView.numberOfCols = 4
            gameView.location = self.location
        }

    }
    
    

}
