//
//  LaunchVC.swift
//  Nova Rush Slot Fever
//
//  Created by SSS CosmicSlot Royale on 10/09/24.
//

import UIKit

class YoNoCosmicLaunchVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var imgBg: UIImageView!
    
    @IBOutlet weak var lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgBg.alpha = 0
        lbl.alpha = 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            
            UIView.animate(withDuration: 2) {
                
                self.imgBg.alpha = 1
                self.lbl.alpha = 0
                
            } completion: { _ in
                print("DONE")
            }

            
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")as! YoNoCosmicHomeVC
            
            self.changeScreenWithVanishEffect(to: vc)
            
        }
        
    }
    
}
