
import Foundation
import CoreLocation
class MyPlayer : Codable {

    
    var name: String?
    var date: String?
    var lat : Double?
    var lng : Double?
    var time : String!
    var index : Int?
    
    init(_ name: String, _ date: String,_ lat: Double, _ lng: Double, _ time: String) {
        self.name = name
        self.date = date
        self.lat = lat
        self.lng = lng
        self.time = time
    }
    
    func printIt(){
        print("name : \(name!) , date: \(date!) , location: \(String(lat!)) ; \(String(lng!)) , time: \(time!)")
    }
}

