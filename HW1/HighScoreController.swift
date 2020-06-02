
import UIKit
import MapKit

class HighScoreController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var HighScore_LST_scores: UITableView!
    @IBOutlet weak var HighScore_MAP_map: MKMapView!
    
    
    var topTenScore:[MyPlayer] = []
    let cellReuseIdentifier = "name_cell"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        HighScore_MAP_map.showsUserLocation = true
        HighScore_LST_scores.delegate = self
        HighScore_LST_scores.dataSource = self
        loadPlayersFromStorage()
        
        

    }
    
    
    
    
    func loadPlayersFromStorage(){
        let allPlayersJson = UserDefaults.standard.string(forKey: "AllPlayers")
       
        
        if let safeAllPlayersJson = allPlayersJson {
            let decoder = JSONDecoder()
            let data = Data(safeAllPlayersJson.utf8)
            do{
                self.topTenScore = try decoder.decode([MyPlayer].self, from: data)
            }catch{}
        }
        if(topTenScore.count > 1){
            topTenScore.sort(by : {$0.time < $1.time})
        }
    }
    
    
    //number of row in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topTenScore.count
    }
    
    //create every cell and assume the text
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : MyCustomCell? = self.HighScore_LST_scores.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? MyCustomCell
        let name = self.topTenScore[indexPath.row].name
        let time = self.topTenScore[indexPath.row].time
        let date = self.topTenScore[indexPath.row].date
        cell?.MyCustomCell_LBL_cell?.text = "\(name!) , \(time!) , \(date!)"
        
        
        if(cell == nil){
            cell = MyCustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        showLoaction(index: indexPath.row)
    }
    
    
    //listener for every cell
    func showLoaction(index: Int){
    
        //create annotate
        let point = MKPointAnnotation()
        point.title = topTenScore[index].name
        point.coordinate = CLLocationCoordinate2DMake(topTenScore[index].lat!,topTenScore[index].lng!)
        HighScore_MAP_map.addAnnotation(point)
        
        //set camera to annotate location
        let center = CLLocationCoordinate2D(latitude: topTenScore[index].lat!, longitude: topTenScore[index].lng!)
        let camera = MKMapCamera(lookingAtCenter: center, fromDistance: 1000.0, pitch: 90.0, heading: 180.0)
        HighScore_MAP_map.setCamera(camera, animated: true)
        
    }
 

    @IBAction func goBack(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToStart", sender: self)
    }
    
    
    
    // MARK: - Navigation

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToStart"){
        
        }

    }


}


