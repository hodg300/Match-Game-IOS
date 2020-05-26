
import Foundation
import CoreLocation
class MyPlayer {

    
    var name: String?
    var date: Date?
    var lat : Double?
    var lng : Double?
    var time : String?
    
    init(_ name: String, _ date: Date,_ lat: Double, _ lng: Double, _ time: String) {
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

