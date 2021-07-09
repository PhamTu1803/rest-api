//
//  CharacterModel.swift
//  API-Realm-Cd
//
//  Created by phamtu on 08/07/2021.
//

import UIKit

class CharacterModel: NSObject {
    var page: Int = 0
    var name: String = ""
    var status: String = ""
    var species: String = ""
    var gender: String = ""
    
    func initLoad(_ json:  [String: Any]) -> CharacterModel{
        if let temp = json["page"] as? Int { page = temp }
        if let temp = json["name"] as? String { name = temp }
        if let temp = json["status"] as? String { status = temp }
        if let temp = json["species"] as? String { species = temp}
        if let temp = json["gender"] as? String { gender = temp}
        
        return self
    }
}

