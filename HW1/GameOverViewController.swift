
import UIKit

class GameOverViewController: UIViewController {
     @IBOutlet weak var gameOver_LBL_resultOfTime: UILabel!
    @IBOutlet weak var gameOver_EDT_name: UITextField!
    @IBOutlet weak var gameOver_VIEW_popUp: UIView!
    @IBOutlet weak var gameOver_BTN_restart: UIButton!
    @IBOutlet weak var gameOver_BTN_menu: UIButton!
    
    
    var fromMode : Int?
    var time : String?
    var location : MyLocation?
    var players : [MyPlayer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        checkIfShowDialog()
        gameOver_LBL_resultOfTime.text = "\(time!)"
        gameOver_BTN_restart.isEnabled = false
        gameOver_BTN_menu.isEnabled = false
        loadPlayersFromStorage()
        
    }
    
    func checkIfShowDialog(){
        if(players.count >= 10){
            let lastPlayerTimeInDouble : Double = (players.last!.time as NSString).doubleValue
            let newPlayerTimeInDouble : Double = (String(gameOver_LBL_resultOfTime.text!) as NSString).doubleValue
            if(lastPlayerTimeInDouble < newPlayerTimeInDouble){
                gameOver_VIEW_popUp.isHidden = true
            }
        }
    }

    @IBAction func onClickRestart(_ sender: Any) {
        self.performSegue(withIdentifier: "goToGame", sender: self)
        

    }
    @IBAction func onClickMenu(_ sender: Any) {
        self.performSegue(withIdentifier: "goToMenu", sender: self)
    }
    
    @IBAction func gameOver_BTN_save(_ sender: Any) {
        
        
        let newPlayer =  MyPlayer(gameOver_EDT_name.text!
            ,createDate(),self.location!.lat!,self.location!.lng!,String(gameOver_LBL_resultOfTime.text!))
       if(gameOver_EDT_name.text == ""){
        newPlayer.name = "Player"
       }
        print("\(String(describing: newPlayer.name))")
        if(players.count > 1){
//            let lastPlayerTimeInDouble : Double = (players.last!.time as NSString).doubleValue
//            let newPlayerTimeInDouble : Double = (newPlayer.time as NSString).doubleValue
        
            //use in userDefault to save player details inside iphone
            if(players.count < 10){
                players.append(newPlayer)
                savePlayersToStorage()
            }else{
                players.removeLast()
                players.append(newPlayer)
                savePlayersToStorage()
            }
        }else{
            players.append(newPlayer)
            savePlayersToStorage()
        }
       
        gameOver_VIEW_popUp.isHidden = true
        view.endEditing(true)
        gameOver_BTN_restart.isEnabled = true
        gameOver_BTN_menu.isEnabled = true
    }
    
    func createDate() -> String{
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        formatter.timeZone = .none
        return formatter.string(from: Date())
    }
    
    func loadPlayersFromStorage(){
        let allPlayersJson = UserDefaults.standard.string(forKey: "AllPlayers")
       
        
        if let safeAllPlayersJson = allPlayersJson {
            let decoder = JSONDecoder()
            let data = Data(safeAllPlayersJson.utf8)
            do{
                self.players = try decoder.decode([MyPlayer].self, from: data)
            }catch{}
             
        }
        players.sort(by : {$0.time < $1.time})
        }
    
    func savePlayersToStorage(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(players)
        let playersJson : String = String(data: data , encoding: .utf8)!
        
        UserDefaults.standard.set(playersJson, forKey: "AllPlayers")
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
    
    
    //Calls this function when the tap is recognized.
@objc func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
}

}

