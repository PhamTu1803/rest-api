//
//  ViewController.swift
//  API-Realm-Cd
//
//  Created by phamtu on 08/07/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func charactertapped(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CharacterViewController") as! CharacterViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

