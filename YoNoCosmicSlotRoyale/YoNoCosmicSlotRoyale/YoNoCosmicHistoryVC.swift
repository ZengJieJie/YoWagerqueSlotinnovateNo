//
//  HistoryVC.swift
//  Nova Rush Slot Fever
//
//  Created by SSS CosmicSlot Royale on 10/09/24.
//

import Foundation
import UIKit

class YoNoCosmicHistoryVC: UIViewController {

    @IBOutlet weak var tbl: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl.delegate = self
        tbl.dataSource = self
        
    }
    

    

}

extension YoNoCosmicHistoryVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        history.isEmpty ? 1 : history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbl.dequeueReusableCell(withIdentifier: "HelperCell", for: indexPath)as! HelperCell
        
        if history.isEmpty{
            cell.lbl.text = "NO HISTORY, PLAY GAME FIRST."
            return cell
        }
        
        cell.lbl.text = history[indexPath.row]
        return cell
    }
    
}

class HelperCell: UITableViewCell{
    
    @IBOutlet weak var lbl: UILabel!
    
}

