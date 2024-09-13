//
//  Vc + Ext.swift
//  Nova Rush Slot Fever
//
//  Created by SSS CosmicSlot Royale on 10/09/24.
//

import Foundation
import UIKit

extension UIViewController{
    
    @IBAction func btnBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    func changeScreenWithVanishEffect(to newViewController: UIViewController) {
        
        guard let navigationController = self.navigationController else { return }

        let animationDuration = 0.5
        
        UIView.animate(withDuration: animationDuration, animations: {
            
            self.view.alpha = 0
            
        }, completion: { _ in
            
            self.view.alpha = 1
            
            let transition = CATransition()
            transition.duration = animationDuration
            transition.type = .fade
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            navigationController.view.layer.add(transition, forKey: kCATransition)
            
            navigationController.pushViewController(newViewController, animated: false)
            
        })
    }


}
