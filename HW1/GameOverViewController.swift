
import UIKit

class GameOverViewController: UIViewController {
     @IBOutlet weak var gameOver_LBL_resultOfTime: UILabel!
    @IBOutlet weak var gameOver_EDT_name: UITextField!
    @IBOutlet weak var gameOver_VIEW_popUp: UIView!
    
    
    var fromMode : Int?
    var time : String?
    var location : MyLocation?
    var players : [MyPlayer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameOver_LBL_resultOfTime.text = "\(time!)s"
        loadPlayersFromStorage()
        
    }
    

    @IBAction func onClickRestart(_ sender: Any) {
        self.performSegue(withIdentifier: "goToGame", sender: self)
        

    }
    @IBAction func onClickMenu(_ sender: Any) {
        self.performSegue(withIdentifier: "goToMenu", sender: self)
    }
    
    @IBAction func gameOver_BTN_save(_ sender: Any) {
        //use in userDefault to save player details inside iphone
        if(players.count < 10){
            players.append(MyPlayer(gameOver_EDT_name.text ?? "PLAYER",Date(),self.location!.lat!,self.location!.lng!,String(gameOver_LBL_resultOfTime.text!)))
        }else{
            players.removeLast()
        }
        savePlayersToStorage()
        gameOver_VIEW_popUp.isHidden = true
        view.endEditing(true)
    }
    
    func loadPlayersFromStorage(){
        let allPlayersJson = UserDefaults.standard.string(forKey: "AllPlayers")
       
        
        if let safeAllPlayersJson = allPlayersJson {
            let decoder = JSONDecoder()
            let data = Data(safeAllPlayersJson.utf8)
            do{
                self.players = try decoder.decode([MyPlayer].self, from: data)
            }catch{}
             printAllPlayers()
            
        }
    }
    
    func savePlayersToStorage(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(players)
        let playersJson : String = String(data: data , encoding: .utf8)!
        
        UserDefaults.standard.set(playersJson, forKey: "AllPlayers")
    }
    
    func printAllPlayers(){
        for player in players{
            player.printIt()
        }
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
