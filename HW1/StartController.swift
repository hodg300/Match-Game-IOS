

import UIKit
import CoreLocation

class StartController: UIViewController {

    @IBOutlet weak var start_BTN_4x4: UIButton!
    @IBOutlet weak var start_BTN_4x5: UIButton!
    @IBOutlet weak var start_BTN_HighScore: UIButton!
    final var MATRIX4X4 = 44
    final var MATRIX5X4 = 54
    var locationManager: CLLocationManager!
    var location : MyLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    

    @IBAction func sendMode(_ sender: UIButton) {
       
        
        if(sender.tag == MATRIX4X4){
            self.performSegue(withIdentifier: "goToGame4x4", sender: self)
        }else if(sender.tag == MATRIX5X4){
            self.performSegue(withIdentifier: "goToGame5x4", sender: self)
        }
        
    }
    
    @IBAction func goToHighScore(_ sender: Any) {
        self.performSegue(withIdentifier: "goToHighScore", sender: self)
    }
    
    
 
            
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if(segue.identifier == "goToGame4x4"){
            let gameView = segue.destination as! GameController
            gameView.numberOfRows = 4
            gameView.numberOfCols = 4
           
//            self.location?.printIt()

            gameView.location = location
        }
        else if(segue.identifier == "goToGame5x4"){
            let gameView = segue.destination as! GameController
            gameView.numberOfRows = 5
            gameView.numberOfCols = 4
            gameView.location = location
        }
        else if(segue.identifier == "goToHighScore"){
//            let secondView = segue.destination as! HighScoreController
        }
    }
    
    

}


    extension StartController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")

        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            self.location = MyLocation(lat,lng)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error=\(error)")
    }
}

