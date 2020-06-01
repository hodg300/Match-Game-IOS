
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
        
        topTenScore.sort(by : {$0.time < $1.time})
       
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
        cell?.MyCustomCell_BTN_cellClick?.setTitle("\(name!) , \(time!) , \(date!)", for: .normal)
        cell?.MyCustomCell_BTN_cellClick?.tag = indexPath.row
        
        
        if(cell == nil){
            cell = MyCustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
        }
        
        return cell!
    }
    
    
    //listener for every cell
    @IBAction func onClickCell(_ sender: UIButton) {
//        topTenScore[1].lat=30.432124
//        topTenScore[1].lng=31.432124
        let center = CLLocationCoordinate2D(latitude: topTenScore[sender.tag].lat!, longitude: topTenScore[sender.tag].lng!)
//        print("status : \(topTenScore[sender.tag].lat!) ,  \(sender.tag)")
        let region = MKCoordinateRegion.init(center: center, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        HighScore_MAP_map.setRegion(region, animated: true)
        
        
    }
 

    
    
    
    // MARK: - Navigation

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToStartActivity"){
            _ = segue.destination as! StartController
           
             
        }

    }


}


