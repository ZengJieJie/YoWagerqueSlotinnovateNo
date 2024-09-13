//
//  StartShotVC.swift
//  Nova Rush Slot Fever
//
//  Created by SSS CosmicSlot Royale on 10/09/24.
//

import UIKit

class YoNoCosmicStartShot: UIViewController {
    
    @IBOutlet weak var viewDesc: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let originalPosition = viewDesc.frame.origin.x
        viewDesc.frame.origin.x = self.view.frame.width
        
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseOut, animations: {
            
            self.viewDesc.frame.origin.x = originalPosition
        }, completion: nil)
        
    }
    
    
}
