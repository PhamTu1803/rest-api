//
//  CharacterViewController.swift
//  API-Realm-Cd
//
//  Created by phamtu on 08/07/2021.
//

import UIKit

class CharacterViewController: UIViewController {
    var listData:[CharacterModel] = [CharacterModel]()
    func getCharacter(andCompletion completion:@escaping (_ moviesResponse: [CharacterModel], _ error: Error?) -> ()) {
        APIService.shared.GetCharacter() { (response, error) in
            if let listData = response{
                self.listData = listData
                DispatchQueue.main.async {
                    self.characterTbview.reloadData()
                }
            }
            completion(self.listData, error)
        }
    }
    @IBOutlet weak var characterTbview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()

       
    }
    private func initTableView() {
        characterTbview.register(UINib(nibName: "Charactercell", bundle: nil), forCellReuseIdentifier: "Charactercell")
        characterTbview.delegate = self
        characterTbview.dataSource = self
        self.getCharacter(){_,_ in}
    }

}
extension CharacterViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Charactercell", for: indexPath) as! Charactercell
        cell.lblname.text = String("\(listData[indexPath.row].name)")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

extension NSObject {
    func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    var className: String {
        return String(describing: type(of: self))
    }
    class var className: String {
        return String(describing: self)
    }
}
