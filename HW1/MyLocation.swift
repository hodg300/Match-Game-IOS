//
//  MyLocation.swift
//  HW1
//
//  Created by user165563 on 5/26/20.
//  Copyright © 2020 hodgohasi. All rights reserved.
//

import Foundation
class MyLocation :Codable{

    var lat : Double?
    var lng : Double?
    
    
    init(_ lat: Double, _ lng: Double) {

        self.lat = lat
        self.lng = lng
    }
    
    func printIt(){
        print("location: \(String(lat!)) ; \(String(lng!))")
    }
}
