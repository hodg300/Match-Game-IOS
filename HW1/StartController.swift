

import UIKit

class StartController: UIViewController {

    @IBOutlet weak var start_BTN_4x4: UIButton!
    @IBOutlet weak var start_BTN_4x5: UIButton!
    @IBOutlet weak var start_BTN_HighScore: UIButton!
    final var MATRIX4X4 = 44
    final var MATRIX4X5 = 45
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendMode(_ sender: UIButton) {
        
        if(sender.tag == MATRIX4X4){
            self.performSegue(withIdentifier: "goToGame4x4", sender: self)
        }else if(sender.tag == MATRIX4X5){
            self.performSegue(withIdentifier: "goToGame4x5", sender: self)
        }
        
    }
    
    @IBAction func goToHighScore(_ sender: Any) {
        self.performSegue(withIdentifier: "goToHighScore", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if(segue.identifier == "goToGame4x4"){
            let secondView = segue.destination as! GameController
            secondView.mode = MATRIX4X4
        }else if(segue.identifier == "goToGame4x5"){
            let secondView = segue.destination as! GameController
            secondView.mode = MATRIX4X5
        }else if(segue.identifier == "goToHighScore"){
            //let secondView = segue.destination as! HighScoreController
        }
    }

}
