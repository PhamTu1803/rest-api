//
//  Charactercell.swift
//  API-Realm-Cd
//
//  Created by phamtu on 08/07/2021.
//

import UIKit

class Charactercell: UITableViewCell {

    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblgender: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
