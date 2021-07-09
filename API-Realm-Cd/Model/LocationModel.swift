//
//  LocationModel.swift
//  API-Realm-Cd
//
//  Created by phamtu on 08/07/2021.
//

import UIKit

class LocationModel: NSObject {
    var id: Int = 0
    var name: String = ""
    var type: String = ""
    var dimension: String = ""
    var residents: String = ""
    
    func initLoad(_ json:  [String: Any]) -> LocationModel{
        if let temp = json["id"] as? Int { id = temp }
        if let temp = json["name"] as? String { name = temp }
        if let temp = json["type"] as? String { type = temp }
        if let temp = json["dimension"] as? String { dimension = temp}
        if let temp = json["residents"] as? String { residents = temp}
        
        return self
    }
}

