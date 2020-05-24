
import UIKit

class HighScoreController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var HighScore_LST_scores: UITableView!
    
    
    var names = ["Apple","Orange","Banana"]
    let cellReuseIdentifier = "name_cell"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        HighScore_LST_scores.delegate = self
        HighScore_LST_scores.dataSource = self
        
    }
    
    
    //number of row in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    //create every cell and assume the text
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : MyCustomCell? = self.HighScore_LST_scores.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? MyCustomCell
        cell?.cell_LBL_name?.text = self.names[indexPath.row]
        
        
        
        if(cell == nil){
            cell = MyCustomCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
        }
        
        return cell!
    }

    
    // MARK: - Navigation

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToStartActivity"){
            _ = segue.destination as! StartController
           
             
        }

    }


}


